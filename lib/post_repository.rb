require_relative "./posts"
class PostRepository 
    
    def all 
        #SELECT * FROM posts
        # Returns an array of user objects
        post_array = []
        sql = "SELECT * FROM posts;"
        result_set = DatabaseConnection.exec_params(sql,[])
        result_set.each do |selected| 
            chosen_post = Post.new()
            chosen_post.id = selected['id'].to_i
            chosen_post.title = selected['title']
            chosen_post.content = selected['content']
            chosen_post.number_of_views = selected['number_of_views'].to_i
            chosen_post.user_id = selected['user_id'].to_i
            post_array << chosen_post
        end 
        return post_array
    end 

    def find(id) 
        #SELECT * FROM posts WHERE id = $1
        # Return a post object
        sql = 'SELECT * FROM posts WHERE id = $1;'
        params = [id]
        result_set = DatabaseConnection.exec_params(sql,params)
        selected = result_set[0]
        returned_post = Post.new()
        returned_post.id = selected['id'].to_i
        returned_post.title = selected['title']
        returned_post.content = selected['content']
        returned_post.number_of_views = selected['number_of_views'].to_i
        returned_post.user_id = selected['user_id'].to_i
        return returned_post

    end 

    def delete(id) 
        # DELETE FROM posts WHERE id = $1
        # Return nothing 
        sql = 'DELETE FROM posts WHERE id = $1'
        params = [id]
        DatabaseConnection.exec_params(sql,params)
        return nil  
    end 

    def create(post_object) 

        # Return nothing
        sql = "INSERT INTO posts(title, content, number_of_views, user_id) VALUES ($1, $2, $3, $4)"
        params = [post_object.title, post_object.content, post_object.number_of_views, post_object.user_id]
        DatabaseConnection.exec_params(sql,params)
        return nil  
    end 

    def update(post_object)
        sql = "UPDATE posts SET title = $1, content = $2, number_of_views = $3, user_id = $4 WHERE id = $5"
        params = [post_object.title, post_object.content, post_object.number_of_views, post_object.user_id, post_object.id]
        DatabaseConnection.exec_params(sql,params)
        return nil 
end 
end 