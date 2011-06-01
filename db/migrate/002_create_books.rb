migration 2, :create_books do
  up do
    create_table :books do
      column :id, Integer, :serial => true
      
    end
  end

  down do
    drop_table :books
  end
end
