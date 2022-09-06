require 'users_repository.rb'
require 'users.rb'

def reset_makersbnb_test
    seed_sql = File.read('spec/seeds/users_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
    connection.exec(seed_sql)
end

RSpec.describe UserRepository do

    before(:each) do
      reset_makersbnb_test
    end
    after(:each) do
        reset_makersbnb_test
      end

  context '#list all users' do
    it "returns a list of all users" do
        repo = UserRepository.new

        users = repo.all

        expect(users.length).to eq 2

        expect(users[0].id).to eq 1
        expect(users[0].username).to eq 'Jack'
        expect(users[0].email_address).to eq 'JackJones@gmail.com'
        expect(users[0].password).to eq 'SkyBlue123'

        expect(users[1].id).to eq 2
        expect(users[1].username).to eq 'Skye'
        expect(users[1].email_address).to eq 'Skyhatesthis@ooutlook.com'
        expect(users[1].password).to eq 'Catperson339'
        end
    end

    context '#find a given user' do
        it "finds a user record" do
            repo = UserRepository.new

            users = repo.find(1)

            expect(users.id).to eq 1
            expect(users.username).to eq 'Jack'
            expect(users.email_address).to eq 'JackJones@gmail.com'
            expect(users.password).to eq 'SkyBlue123'
        end
    end

    context '#create a single user' do
        it "adds a new user record" do
            repo = UserRepository.new

            new_user = User.new

            new_user.username = 'roi'
            new_user.email_address = 'roi@gmail.com'
            new_user.password = 'password123'

            repo.create(new_user)

            all_users = repo.all

            expect(all_users.length).to eq 3

            expect(all_users.last.id).to eq  3
            expect(all_users.last.username).to eq  'roi'
            expect(all_users.last.email_address).to eq  'roi@gmail.com'
            expect(all_users.last.password).to eq 'password123'
        end
    end

    context '#updates a given user' do
        it "updates a user record" do
            repo = UserRepository.new

            user2 = repo.find(2)

            user2.email_address = 'changed@gmail.com'
            user2.username = 'changed'
            user2.password = 'change123'

            repo.update(user2)

            updated_user2 = repo.find(2)

            expect(updated_user2.username).to eq 'changed'
            expect(updated_user2.email_address).to eq 'changed@gmail.com'
            expect(updated_user2.password).to eq 'change123'
        end
    end

    context '#delete a user' do
        it "deletes a user record" do
            repo = UserRepository.new

            repo.delete(2)

            all_users =  repo.all

            expect(all_users.length).to eq 1

            expect(all_users[0].id).to eq  1
            expect(all_users[0].username).to eq  'Jack'
            expect(all_users[0].email_address).to eq  'JackJones@gmail.com'
            expect(all_users[0].password).to eq 'SkyBlue123'
        end
    end
end
