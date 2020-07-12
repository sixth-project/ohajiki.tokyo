module ApplicationHelper

  # ページごとの完全なタイトルを返す

  def full_title(page_title = '')
    base_title = "Ohajiki Tokyo"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def correct_user?(user) #ユーザーの同一を確認
    user == current_user
  end

  def avatar_for(user)
    if user.avatar
      image_tag "/user_avatars/#{user.avatar}",class: "profile_image", size: "100x100"
    else
      image_tag "avatar.png",class: "profile_image",size: "100x100"
    end
  end

end
