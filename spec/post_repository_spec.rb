require "post_repository"

def reset_students_table
  seed_sql = File.read("spec/seeds_user.sql")
  connection = PG.connect({ host: "127.0.0.1", dbname: "social_network" })
  connection.exec(seed_sql)
end

describe PostRepository do
  before(:each) do
    reset_students_table
  end

  it "Returns all of the posts" do
    post_repo = PostRepository.new()
    posts = post_repo.all
    expect(posts[0].id).to eq 1
    expect(posts[0].title).to eq "Big Post"
    expect(posts[0].content).to eq "Isnt this cool?"
    expect(posts[0].number_of_views).to eq 12
    expect(posts[0].user_id).to eq 1
    expect(posts[1].id).to eq 2
    expect(posts[1].content).to eq "I think pineapple is bad"
    expect(posts[1].number_of_views).to eq 843
    expect(posts[2].id).to eq 3
  end

  it "Finds a specific post" do
    post_repo = PostRepository.new()
    selected_post = post_repo.find(2)
    expect(selected_post.id).to eq 2
    expect(selected_post.title).to eq "Small post"
    expect(selected_post.content).to eq "I think pineapple is bad"
    expect(selected_post.number_of_views).to eq 843
    expect(selected_post.user_id).to eq 2
  end

  it "Deletes a post" do
    post_repo = PostRepository.new()
    post_repo.delete(2)
    all_posts = post_repo.all
    expect(all_posts.length).to eq 2
    expect(all_posts[0].id).to eq 1
    expect(all_posts[0].title).to eq "Big Post"
    expect(all_posts[0].content).to eq "Isnt this cool?"
    expect(all_posts[0].number_of_views).to eq 12
    expect(all_posts[1].title).to eq "Medium post"
  end



  it "Creates a post" do
    post_repo = PostRepository.new()
    new_post = Post.new()
    new_post.title = "Inserted post"
    new_post.content = "I hope this works"
    new_post.number_of_views = 532
    new_post.user_id = 2
    post_repo.create(new_post)
    all_posts = post_repo.all
    expect(all_posts).to include(have_attributes(title: new_post.title, content: new_post.content, number_of_views: new_post.number_of_views,user_id: new_post.user_id))
  end


  it "Updates a post" do
    post_repo = PostRepository.new()
    updated_post = Post.new()
    updated_post.title = "Does this work"
    updated_post.content = "Becuase it's lunch soon and I'm hungry"
    updated_post.number_of_views = 19
    updated_post.user_id = 3
    updated_post.id = 2 
    post_repo.update(updated_post)
    selected_post = post_repo.find(2)
    expect(selected_post.title).to eq updated_post.title
    expect(selected_post.content).to eq updated_post.content
    expect(selected_post.number_of_views).to eq 19 
    expect(selected_post.user_id).to eq 3
    expect(selected_post.id).to eq 2
  end

end 