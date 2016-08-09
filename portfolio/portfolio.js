
function random_color()
{
    var rgb = ['a','b','c','d','e','f','0','1','2','3','4','5','6','7','8','9'];
    color = '#'  //this is what we'll return!
    for(var i = 0; i < 6; i++) 
    {
      x = Math.floor((Math.random()*16))
      color += rgb[x]; 
    }
      return color;
}

function random_size()
{
    var x;
    x = Math.floor(Math.random()*10);
    return x; 
}

$(document).ready(function(){
    alert('hello');
    // for (var i = 0; i < 500; i++) {
    //         $(this).siblings().children().css('color', random_color());
    //     }
    
    // setInterval($('p').css('color', random_color()),1000);

    $('.ranColor').hover(function(event){
        event.stopPropagation();
        setInterval($(this).siblings().css('color', random_color()),10);
    })

    $(this).hover(function(){
        alert('You cannot leave!');
    });

    $('.ranSize').click(function(event){
        event.stopPropagation();
        $(this).siblings().css('font-size', random_size() + 'em');
    });

});

$(function(){
    $(".draggable").draggable();
    $(".droppable").droppable({
        over: function(event, ui) {
            $(this).hide();
        }
    });
});