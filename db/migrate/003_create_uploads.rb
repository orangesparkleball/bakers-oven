migration 3, :create_uploads do
  up do
    create_table :uploads do
      column :id, Integer, :serial => true
      column :file, Text
      column :created_at, DateTime
    end
  end

  down do
    drop_table :uploads
  end
end
