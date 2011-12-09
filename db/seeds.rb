# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Clean all data
Role.delete_all
Permission.delete_all
User.delete_all
Story.delete_all
Page.delete_all

# Fill roles
admin = Role.create(:name => "admin")
redactor = Role.create(:name => "redactor")
user = Role.create(:name => "user")
guest = Role.create(:name => "guest")

admin.permissions.create(:hero => true, :pages => true, :stories => true, :comments => true)
redactor.permissions.create(:hero => true, :pages => false, :stories => true, :comments => true)
user.permissions.create(:hero => false, :pages => false, :stories => true, :comments => true)
guest.permissions.create(:hero => false, :pages => false, :stories => false, :comments => true)

# Fill users
admin = User.create(:login => "admin",
  :password => "admin",
  :email => "admin@admin",
  :firstname => "Ondrej",
  :lastname => "Danko",
  :role => admin
)
redactor = User.create(:login => "redactor", :password => "redactor", :role => redactor)
user = User.create(:login => "user",  :password => "user",  :role => user)
guest = User.create(:login => "guest",  :password => "guest",  :role => guest)

# Fill stories
Story.create(:user => redactor,
  :title => "Story One",
  :content => %{<p>
  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sit amet justo lectus, eu luctus orci. Quisque sit amet erat mauris. Nulla purus neque, dictum sed porta vitae, suscipit id neque. Curabitur posuere consequat tortor at hendrerit. Sed eget vestibulum nisl. Curabitur convallis mauris sit amet eros laoreet bibendum. Mauris pellentesque odio et tortor fringilla aliquam. Curabitur elementum interdum libero, in rhoncus tellus congue at. Donec placerat sagittis urna, sit amet auctor tellus euismod eu.</p>
  <p>Duis a turpis nisl, mollis semper risus. Ut massa neque, condimentum sed fringilla at, facilisis non magna. Suspendisse nec quam sapien, at facilisis orci. Nam rutrum commodo lacus, ut dapibus magna pretium eget. Aliquam at risus augue. Nam at dolor vitae urna mollis ullamcorper vitae a enim. Sed venenatis hendrerit iaculis. Praesent ac leo est.</p>})

Story.create(:user => redactor,
  :title => "Story Two",
  :content => %{<p>
  Aenean pellentesque massa sed urna suscipit ut porttitor augue vestibulum. Phasellus vel justo quis libero dictum laoreet quis ac augue. Vivamus scelerisque pulvinar dictum. Mauris consectetur odio non mi viverra sed pellentesque risus tincidunt. Nulla facilisi. Nulla at purus sed magna pulvinar euismod id eget tortor. Integer id nulla enim, sit amet porttitor dui. Praesent felis erat, posuere sed cursus gravida, tincidunt ut lacus. Fusce quis mi urna, ut feugiat quam. Cras libero ligula, malesuada quis elementum a, convallis vel mi. Vivamus sollicitudin, ligula sed tristique gravida, purus lacus lobortis elit, nec luctus magna tortor quis purus. Etiam egestas urna dui, suscipit posuere sapien. Nam ornare purus a ipsum iaculis facilisis. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aliquam neque nibh, gravida eget hendrerit cursus, ultricies a enim. Suspendisse eget egestas erat.</p>})

# Fill pages
Page.create(:user => admin,
  :title => "Lorem Ipsum",
  :content => %{<p>
  Quisque non nibh non felis sollicitudin ullamcorper. Vivamus in ligula vel massa dictum eleifend ac nec purus. Duis sagittis, massa at molestie faucibus, velit ante condimentum mi, non iaculis eros ipsum vel ipsum. Aliquam at iaculis ipsum. Donec malesuada tempus interdum. Donec cursus mollis nulla ac ultrices. Pellentesque ante neque, hendrerit vitae cursus ac, porttitor sed felis. Cras rutrum laoreet varius. Maecenas in eros et nisl adipiscing venenatis a eu mauris. Morbi vestibulum enim id urna dignissim eu luctus mauris aliquam. Phasellus nec leo sed eros cursus consequat a sed est. Quisque sollicitudin cursus eros sit amet suscipit. Mauris mattis vulputate ipsum, vel varius velit interdum vitae.</p>
  <p>Integer quis justo lectus, eget lobortis nisi. Integer at velit sed metus gravida congue. Suspendisse condimentum, urna sit amet facilisis consectetur, turpis odio mattis est, sit amet ultricies est quam pellentesque nunc. Mauris mollis tortor vitae dui congue ultrices. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Cras sed magna vel turpis eleifend interdum. Nullam luctus sem vel est bibendum elementum. Phasellus mi velit, scelerisque sed blandit et, posuere eu mauris. Maecenas lacinia lectus non nulla viverra in cursus dolor pharetra. Donec pharetra nunc sed tellus ultricies in pretium purus pellentesque.</p>})
    
