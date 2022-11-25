class ItemsController < ApplicationController

def index
  if(params["user_id"])
    user = User.find_by(id: params["user_id"])
    if(user)
    render json: user.items, status: :ok
    else
      render json: "User not found", status: 404
    end
  else
    items = Item.all
    render json: items, include: :user
  end
end

  def show
    item = Item.find_by(id: params[:id])
    if(item)
      render json: item, status: :ok
    else
      render json: { error: "Item not found!" }, status: 404
    end
  end

  def create
    user = User.find_by(id: params["user_id"])
    if(user)
      new_item = Item.create(items_params)
      user.items << new_item

    render json: new_item, status: 201
    else
      render json: { error: "user not found"}, status: 404
    end
  end

  private
 def items_params
  params.permit(:name, :description, :price)
 end
end
