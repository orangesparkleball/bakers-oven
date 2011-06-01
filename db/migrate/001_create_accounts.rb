migration 1, :create_accounts do
  up do
    create_table :accounts do
      column :id, Integer, :serial => true
      column :name, String
      column :surname, String
      column :email, String
      column :crypted_password, String
      column :role, String
    end
  end

  down do
    drop_table :accounts
  end
end
