require_relative "./users"
class UserRepository 

    def all 
        #SELECT * FROM users
        # Returns an array of user objects
        student_array = []
        sql = "SELECT * FROM users;"
        result_set = DatabaseConnection.exec_params(sql,[])
        result_set.each do |selected| 
            chosen_user = User.new()
            chosen_user.id = selected['id'].to_i
            chosen_user.email = selected['email']
            chosen_user.username = selected['username']
            student_array << chosen_user
        end 
        return student_array
    end 

    def find(id) 
        #SELECT * FROM users WHERE id = $1
        # Return a user object
        sql = 'SELECT * FROM users WHERE id = $1;'
        params = [id]
        result_set = DatabaseConnection.exec_params(sql,params)
        result = result_set[0]
        returned_user = User.new()
        returned_user.id = result['id'].to_i
        returned_user.email = result['email']
        returned_user.username = result['username']
        return returned_user

    end 

    def delete(id) 
        # DELETE FROM users WHERE id = $1
        # Return nothing 
        sql = 'DELETE FROM users WHERE id = $1'
        params = [id]
        DatabaseConnection.exec_params(sql,params)
        return nil  
    end 

    def create(user_object) 
        # INSERT INTO users('email', 'username') VALUES ('$1', '$2')
        # Return nothing
        sql = "INSERT INTO users(email, username) VALUES ($1, $2)"
        params = [user_object.email, user_object.username]
        DatabaseConnection.exec_params(sql,params)
        return nil  
    end 

    def update(user_object)
        sql = "UPDATE users SET email = $1, username = $2 WHERE id = $3"
        params = [user_object.email, user_object.username, user_object.id]
        DatabaseConnection.exec_params(sql,params)
        return nil 
    end 
end 