Given /^the following articles$/ do |table|
  table.hashes.each do |item|
  	article = Article.get_or_build_article()
  	article.title = item[:title]
  	article.body = "<p>\r\n\t#{item[:body]}</p>\r\n"
  	article.author = item[:author]
    article.user = User.find_by_login(item[:author])

    article.save!
  end
end

Given /^the following comments to article$/ do |table|
  table.hashes.each do |item|
    article = Article.find_by_title(item[:article])
    user = User.find_by_login(item[:author])

    hash_comment = Hash.new
    hash_comment[:author] = item[:author]
    hash_comment[:email] = item[:email]
    hash_comment[:url] = item[:url]
    hash_comment[:body] = item[:body]

    comment = article.add_comment(hash_comment.symbolize_keys)
    comment.user_id = user.id

    comment.save!
    article.save!
  end
end

private

def new_comment_defaults
  { :ip  => "192.168.0.1",
    :author     => 'Anonymous',
    :published  => true,
    :user       => @current_user,
    :user_agent => request.env['HTTP_USER_AGENT'],
    :referrer   => request.env['HTTP_REFERER'],
    :permalink  => @article.permalink_url }
end

# Given /^I visit show page of article "(.*?)"$/ do |article_title|
#   article = Article.find_by_title(article_title)
  
#   title = article.title.parameterize
#   year = article.created_at.year
#   month = article.created_at.month
#   day = article.created_at.day

#   name_path = "/#{year}/#{month}/#{day}/#{title}"
  
#   visit name_path
# end

# Given /^the following users$/ do |table|
#   table.hashes.each do |item|
#   	user = User.new
#   	user.login = item[:login]
#   	user.password = "123456"
#   	user.email = "#{item[:email]}@gmail.com"

#   	user.save!
#   end
# end

# Given /^I am logged in as "(.*?)"$/ do |user_name|
#   visit '/accounts/login'
#   fill_in 'user_login', :with => user_name
#   fill_in 'user_password', :with => '123456'
#   click_button 'Login'
#   if page.respond_to? :should
#     page.should have_content('Login successful')
#   else
#     assert page.has_content?('Login successful')
#   end
# end

# "article"=>{"published"=>"1", "allow_pings"=>"0", "allow_comments"=>"1", "published_at"=>"November 16, 2014 03:45 PM GMT-0400 (AST)", "password"=>"[FILTERED]", "permalink"=>"", "text_filter"=>"markdown smartypants", "post_type"=>"read", "title"=>"Novo Article", "body_and_extended"=>"", "keywords"=>"", "excerpt"=>""}