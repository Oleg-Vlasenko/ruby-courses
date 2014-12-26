module ApplicationHelper
  def signed_in?
    !@current_customer.nil?
  end

  def paginate_path(page_num)
    if params[:ctg]
      shop_by_ctg_path(page: page_num, ctg: params[:ctg])
    else
      shop_path(page: page_num)
    end
  end

  def current_page
    if params[:controller] == 'shop' && params[:action] == 'home'
      return 'home'
    elsif params[:controller] == 'shop' && params[:action] == 'index'
      return 'shop'
    end

    params[:controller] + '/' + params[:action]
  end

  def render_paginate_btn(button)
    if button.html_class.to_s[/disabled/]
      li_data = content_tag(:span, button.text)
    else
      li_data = content_tag(:a, button.text, href: paginate_path(button.page))
    end
    content_tag(:li, li_data, class: button.html_class)
  end

  def render_category_link(category)
    a_href = content_tag(:a, category.title, href: shop_by_ctg_path(ctg: category))
    li_class = category.id.to_s == params[:ctg] ? 'category active' : 'category'
    content_tag(:li, a_href, class: li_class)
  end

  def render_home_link(link_text = 'HOME')
    a_href = content_tag(:a, link_text, href: home_path)
    li_class = current_page == 'home' ? 'active' : nil
    content_tag(:li, a_href, class: li_class)
  end

  def render_shop_link(link_text = 'SHOP')
    a_href = content_tag(:a, link_text, href: shop_path)
    li_class = current_page == 'shop' ? 'active' : nil
    content_tag(:li, a_href, class: li_class)
  end

  def rating_star(number, rating_number)
    span_class = (number <= rating_number) ? 'marked' : 'empty'
    span_class << ' rating-star'
    content_tag(:span, '', class: span_class, value: number.to_s)
  end

  def render_rating_stars(rating_number)
    content_tag(:span, class: 'rating-bar') do
      5.times do |i|
        concat content_tag(:input, '', type: 'radio')
        concat rating_star(i+1, rating_number)
      end
    end
  end

  def render_editable_rating_stars(rating_number)
    content_tag(:span, id: 'rating-bar', class: 'rating-bar') do
      5.times do |i|
        concat content_tag(:input, '', type: 'radio')
        concat rating_star(i+1, rating_number)
      end

      concat content_tag(:input, '', { id: 'rating', name: 'review[rating]', hidden: true, value: rating_number.to_s })
    end
  end

  def render_sign_in_link
    content_tag(:a, 'Sign in', href: auth_path)
  end

  def render_register_link
    content_tag(:a, 'Register', href: new_customer_path)
  end

  def render_sign_out_link
    content_tag(:a, 'Sign out', href: sign_out_path)
  end

  def group_class(field_with_errors = false)
    cls = 'field form-group'
    cls.concat(' has-error') if field_with_errors
    cls
  end
end
