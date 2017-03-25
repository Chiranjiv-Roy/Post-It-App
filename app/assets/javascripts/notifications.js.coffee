class Notifications
	constructor: ->
 		@notifications = $("[data-behavior='notifications']")
 		console.log("hi")
 		@setup() if @notifications.length > 0

 	setup: ->
 		$("[data-behavior='notifications-link']").on "click", @handleClick
 		$.ajax(
 		  url: "http://localhost:3000/notifications.json",
          dataType: "JSON",
          method: "GET",
          success: @handleSuccess
          error: alert ("i too failed")
 		)

 	handleClick: (e) ->
 		$.ajax(
 		  url: "/notifications/mark_as_read",
 		  dataType: "JSON",
 		  method: "POST",
 		  success: ->
 		    console.log("hiiiii")
 		    $("[data-behavior='unread-count']").text(0)
 		)	

    handleSuccess: (data) =>
        items = $.map data, (notification) ->
        	'<a class="dropdown-item" href="#{notification.url}"> #{notification.actor} #{notification.action}</a>'
        $("[data-behavior='unread-count']").text(items.length)
        $("[data-behavior='notification-items']").html(items)
         

jQuery ->
    new Notifications
