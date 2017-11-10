class CommentsController < ApplicationController
  # http_basic_authenticate_with name: "izak", password: "secret", only: :destroy
  before_action :load_commentable
  
  # def index
  #   @comments = @commentable.comments
  # end

  # def new
  #   @comment = @commentable.comments.new
  # end

  def create
    
    @comment = @commentable.comments.new(comment_params)
    @comment.commenter = current_admin.user_name    
    
      if @comment.blank?  || @comment.save
        redirect_to @commentable, notice: "Comment created."
      else         
      # redirect_to @commentable,notice:"#{ @comment.errors.full_messages}"  
      redirect_to @commentable,notice: "#{ render_to_string :partial => '/shared/errors'}"
      end
  end
   
    def edit		
     @comment = @commentable.comments.find(params[:id])		
    end		    end
     		     
   def update		    
     @comment = @commentable.comments.find(params[:id])		  
     respond_to do |format|		
       if @comment.update_attributes(comment_params)		
         #redirect_to @comment.commentable, notice: "Comment was updated."		
         format.json { render @comment }		
         format.html { render :show }		
       else		
         format.json { render json: { error: error_response }.to_json, status: :unprocessible_entity }		
         format.html { flash[:error] = @comment.error unless flash[:error]; render :edit }		
       end        		
     end		
  		  
   end  
    

  def destroy
    @comment = @commentable.comments.find(params[:id])
    if @comment.destroy
      redirect_to @commentable, notice: "Comment deleted."
    end    
  end
  private
    def comment_params
      params.require(:comment).permit(:body)
    end
    
    def load_commentable
      resource, id = request.path.split('/')[1, 2]
      @commentable = resource.singularize.classify.constantize.find(id)
    end
    
    def find_commentable
        params.each do |name, value|
            if name =~ /(.+)_id$/
                return $1.classify.constantize.find(value)
            end
        end
    end
end
