class User < ApplicationRecord
  has_many :categories, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :tasks, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true

  auto_strip_attributes :username, :email, squish: true

  def self.seed_with_sample_data(user) #TODO: Maybe I would be able to use non static method but meh
    category_personal = user.categories.create({title:  "Osobní", color: '#2ecc71'})
    category_school = user.categories.create({title:  "Škola", color: '#3498db'})
    user.categories.create({title:  "Práce", color: '#e74c3c'})

    tag_ucl = user.tags.create({title: 'UCL', color: '#e67e22'})
    user.tags.create({title: 'JSE', color: '#f1c40f'})
    tag_web = user.tags.create({title: 'WEB', color: '#16a085'})
    user.tags.create({title: '3DT', color: '#9b59b6'})
    user.tags.create({title: 'PR1', color: '#34495e'})
    user.tags.create({title: 'PES', color: '#95a5a6'})
    tag_buy = user.tags.create({title: 'Nákupy', color: '#2ecc71'})
    user.tags.create({title: 'Wishlist', color: '#3498db'})

    user.tasks.create(
        {:title => 'Toto je jednoduchý úkol 👎', :is_done => false}
    )

    user.tasks.create(
        {:title => 'Toto je už dokončený úkol 👍', :is_done => true}
    )

    user.tasks.create(
        {:title => 'Nakoupit na večeři 🌭', :is_done => false, :category => category_personal, :tags => [tag_buy]}
    )

    user.tasks.create(
        {:title => 'Udělat semestrální práci z předmětu WEB 🕸', :is_done => false, :category => category_school, :tags => [tag_ucl, tag_web]}
    )

    user.save!
  end
end
