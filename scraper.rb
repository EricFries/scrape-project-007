require 'Nokogiri'
require 'open-uri'
# require 'pry'

def get_student_links
  html = open('http://ruby007.students.flatironschool.com/')
  index_page_data = Nokogiri::HTML(html)
  links = index_page_data.css('a')

  parsed_links = links.collect do |link|
    link['href']
  end

  #remove non-student links manually & normalize links
   student_links = parsed_links[17..74].uniq
   student_links.collect do |link|
    link.prepend("http://ruby007.students.flatironschool.com/")
  end
end

student_links = get_student_links

def create_student_hash(student_links)
  students_array = []
  student_links.each do |link|
    html = open(link)
    student_page_data = Nokogiri::HTML(html)
    # binding.pry

    name = student_page_data.css('h4.ib_main_header').text
    #try to add a space between schools for people w/ 2
    edu = student_page_data.css('div#ok-text-column-3 li').text
    bio = student_page_data.css('div#ok-text-column-2 p').first.text.strip
    work = student_page_data.css('div#ok-text-column-4 p').first.text.strip

    students_array << {:name => name, :education => edu, :bio => bio, :work => work}
end
puts students_array
end

create_student_hash(student_links)