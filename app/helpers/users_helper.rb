module UsersHelper

  def avatar_for(user)
    if user.user_avatar?
      image_tag(user.user_avatar.url, alt: user.name, class: 'avatar')
    else
      default_avatar(user)
    end
  end

  def default_avatar(user)
    male_avatar_url = '/default_avatars/default_avatar_male.jpg'
    female_avatar_url = '/default_avatars/default_avatar_female.png'
    if user.male?
      image_tag(male_avatar_url, alt: user.name, class: 'avatar')
    else
      image_tag(female_avatar_url, alt: user.name, class: 'avatar')
    end
  end
end
