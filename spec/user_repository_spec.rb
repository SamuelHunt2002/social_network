require "user_repository"

def reset_students_table
  seed_sql = File.read("spec/seeds_user.sql")
  connection = PG.connect({ host: "127.0.0.1", dbname: "social_network" })
  connection.exec(seed_sql)
end

describe UserRepository do
  before(:each) do
    reset_students_table
  end

  it "Returns all of the users" do
    user_repo = UserRepository.new()
    users = user_repo.all
    expect(users[0].id).to eq 1
    expect(users[0].email).to eq "test@hotmail.com"
    expect(users[0].username).to eq "first_user"
    expect(users[1].id).to eq 2
    expect(users[1].email).to eq "OtherTest@gmail.com"
    expect(users[1].username).to eq "second_user"
    expect(users[2].id).to eq 3
  end

  it "Returns one chosen user" do
    user_repo = UserRepository.new()
    selected_user = user_repo.find(1)
    expect(selected_user.id).to eq 1
    expect(selected_user.email).to eq "test@hotmail.com"
    expect(selected_user.username).to eq "first_user"
  end

  it "Returns the third person when chosen" do
    user_repo = UserRepository.new()
    selected_user = user_repo.find(3)
    expect(selected_user.id).to eq 3
    expect(selected_user.email).to eq "finalTest@yahoo.com"
    expect(selected_user.username).to eq "third_user"
  end

  it "Deletes a user" do
    user_repo = UserRepository.new()
    length_at_start = user_repo.all.length
    user_repo.delete(2)
    users = user_repo.all
    expect(users[0].id).to eq 1
    expect(users[0].email).to eq "test@hotmail.com"
    expect(users[0].username).to eq "first_user"
    expect(users[1].id).to eq 3
    expect(users[1].email).to eq "finalTest@yahoo.com"
    expect(users[1].username).to eq "third_user"
    length_at_end = user_repo.all.length
    bigger_at_start = length_at_start > length_at_end
    expect(bigger_at_start).to eq true
  end

  it "Creates a user" do
    user_repo = UserRepository.new()
    new_user = User.new()
    new_user.email = "four@askjeeves.com"
    new_user.username = "user_four"
    user_repo.create(new_user)
    all_users = user_repo.all
    expect(all_users).to include(have_attributes(email: new_user.email, username: new_user.username))
  end

  it "Updates a user" do
    user_repo = UserRepository.new()
    updated_user = User.new()
    updated_user.email = "newemail@email.com"
    updated_user.username = "first_user"
    updated_user.id = 1 
    user_repo.update(updated_user)
    selected_user = user_repo.find(1)
    expect(selected_user.email).to eq "newemail@email.com"
    expect(selected_user.username).to eq "first_user"
    expect(selected_user.id).to eq 1
  end
end
