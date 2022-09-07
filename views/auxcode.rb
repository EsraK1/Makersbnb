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
 registration



        ----------- FIRST PROPERTIES WORKING

<html>
  <head></head>
  <body>
    <h1>List of properties</h1>
    <p>
      <% @properties.each do |property| %>
        <%= " --- Start of property info --- " %><br>
        <%= "Property ID: #{property.id}"%><br>
        <%= "Property: #{property.title}"%><br>
        <%= "Property description: #{property.description}"%><br>
        <%= "Property price per night: £#{property.price_per_night}"%><br>
        <%= "Property owner: #{property.user_id}"%><br>
        <%=" --- End of property ID: #{property.id} info --- " %><br>
      <% end %></b>
    </p>
  </body>
</html>


------- FORM

<form method="POST" action="/property">

<div>
<label>Property title</label>
<input type="text" name="title"/>
</div>

<div>
<label>Property description</label>
<input type="text" name="description"/>
</div>

<div>
<label>Property price per night</label>
<input type="text" name="price_per_night"/>
</div>

<input type="submit"/>
</form>

