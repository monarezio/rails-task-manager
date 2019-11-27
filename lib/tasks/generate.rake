namespace :generate do
  desc "TODO"
  task test_data: :environment do
    last_name = RandomWord.nouns.next
    username = "#{last_name.sub '_', ' '}"
    email = "#{last_name.sub '_', '.'}#{rand(1000)}@gmail.com"

    puts "Setting username: #{username}"
    puts "Setting email: #{email}"

    user = User.create({email: email, username: username, password: '123456'})
    user.save!

    tags = []
    50.times do #Tags
      tag_title = "#{RandomWord.nouns.next}"
      tag_color = "##{SecureRandom.hex(3)}"
      tags << user.tags.create({title: tag_title, color: tag_color})
    end

    categories = []
    20.times do #Categories
      category_name = RandomWord.nouns.next.sub '_', ' '
      category_color = "##{SecureRandom.hex(3)}"

      category = user.categories.create({title: category_name, color: category_color})

      20.times do #Tasks
        task_name = "#{RandomWord.nouns.next.sub '_', ' '}"
        task_description = if rand(2) === 1
                             ''
                           else
                             BetterLorem.w(30, true, true)
                           end

        task = user.tasks.create({
                                     title: task_name,
                                     note: task_description,
                                     category_id: rand(10) != 1 ? category.id : nil,
                                     is_done: rand(2) === 1
                                 })

        added_tags = []
        tags_amount = rand(10)
        while added_tags.count != tags_amount
          possible_tag = tags.sample
          unless added_tags.include? possible_tag.id
            added_tags << possible_tag.id
            task.tags << possible_tag
          end
        end
      end

      categories << category
    end

    user.save!

    puts "User generated with password '123456'!"
  end

end
