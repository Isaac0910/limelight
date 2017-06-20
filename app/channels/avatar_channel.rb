class AvatarChannel < ApplicationCable::Channel
  def subscribed
    @stage = Stage.find_by_slug!(params[:slug])
    stream_for @stage
  end

  def hold(data)
    unless current_user.nil?
      avatar = @stage.avatars.find_by_id!(data['avatar_id'])
      AvatarChannel.broadcast_to @stage, { username: current_user.nickname, action: 'hold', avatar_id: avatar.id }
    end
  end

  def drop(data)
    unless current_user.nil?
      avatar = @stage.avatars.find_by_id!(data['avatar_id'])
      AvatarChannel.broadcast_to @stage, { action: 'drop', avatar_id: avatar.id }
    end
  end
end
