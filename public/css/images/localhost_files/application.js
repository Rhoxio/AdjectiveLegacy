$(document).ready(function() {
  bindEvents();
});


function bindEvents() {
  $(".add").on("click", function(event){
    event.preventDefault();

    newTodo();
  })

  $(".delete").on("click", function(event){
    event.preventDefault();

    deleteTodo();
  })

  $(".complete".on("click", function(event){
    event.preventDefault();

    completeTodo();
  })
}


var newTodo = function(){
  $.ajax({
    url: "/add_todo",
    type: "POST",
    data: $('form').serialize()
  }).done(function(data){
    entry = buildTodo(data["todo_content"]).addClass('todo_template')
    $('.todo_list').append(entry)
  })
}

var completeTodo = function(id){
  $.ajax({
    url: "/done/:id",
    
  })
}

function buildTodo(todoName) {
  // gets todoTemplate stored in DOM.
  var todoTemplate = $.trim($('#todo_template').html());
  // Creates an jQueryDOMElement from the todoTemplate.
  var $todo = $(todoTemplate);
  // Modifies it's text to use the passed in todoName.
  $todo.find('h2').text(todoName);
  // Returns the jQueryDOMElement to be used elsewhere.
  return $todo;
}

//Create functions to add, remove and complete todos
