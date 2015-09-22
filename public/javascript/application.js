$(document).ready(function() {
  $('i').click(function() {
    var id = this.id
    var elem = this
    $.ajax({
      url: "/users/upvote/" + id,
    }).done(function() {
        console.log(elem);
        elem.classList.toggle("grey-text");
        elem.classList.toggle("teal-text");
        console.log(elem.classList);
        if($.inArray("teal-text", elem.classList) !== -1){
          var text = $(elem).next().text();
          text = Number(text) + 1;
          $(elem).next().text(text);  
        }else{
          var text = $(elem).next().text();
          text = Number(text) - 1;
          $(elem).next().text(text);  
        }
    });
  });
});
