defmodule FoodTruck.Repo.Migrations.CreateLocations do
  use Ecto.Migration

  def up do
    create table(:locations) do
      add :description, :text
      add :facility_type, :string
      add :street, :string
      add :city, :string

      add :company_id, references(:companies, on_delete: :delete_all)

      timestamps()
    end

    execute("SELECT AddGeometryColumn('locations', 'coordinates', 4326, 'POINT', 2)")
    execute("CREATE INDEX location_coordinates_index on locations USING gist (coordinates)")

    create index(:locations, :street)
    create index(:locations, :facility_type)
  end

  def down do
    drop index(:locations, :street)
    drop index(:locations, :facility_type)
    drop index(:locations, :coordinates, name: :location_coordinates_index)
    drop table(:locations)
  end
end
