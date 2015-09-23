$(document).ready(function() {
  $('.stars').raty({ 
    scoreName: 'review_rating',
    starOff : '/images/note-off.png',
    starOn  : '/images/note-on.png',

  });

  $('select').material_select();
  $("i:contains('thumb_up')").click(function() {
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
          if(text > 1) {
            $(elem).next().next().text("points");
          }else{
            $(elem).next().next().text("point");
          }  
        }else{
          var text = $(elem).next().text();
          text = Number(text) - 1;
          $(elem).next().text(text);  
          if(text > 1) {
            $(elem).next().next().text("points");
          }else{
            $(elem).next().next().text("point");
          }
        }
    });
  });
});
