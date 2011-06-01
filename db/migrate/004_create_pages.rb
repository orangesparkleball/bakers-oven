migration 4, :create_pages do
  up do
    create_table :pages do
      column :id, Integer, :serial => true
      column :title, String
      column :subtitle, String
      column :body, Text
    end
  end

  down do
    drop_table :pages
  end
end
