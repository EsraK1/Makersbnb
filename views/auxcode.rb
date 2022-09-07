<%= @properties[1].title %>

<% @properties.each do |property| %>
    <%= property.title %></a><br />
    <%= property.description %></a><br />
<% end %></b>


<%= @properties[0].title %>

<% if @propertiesu == [] then %>
<%= @propertiesu %>
<% end %>


        And this is part of the test<br>
        <% a = PropertyRepository.new.all %><br>
        <% puts "I'm inside erb HTML file" %>
        <% puts a[0].title %>
        <% puts @properties[1].title %>
        <% puts "I'm inside erb HTML file" %>
        I go through
