// var article = document.getElementById('comments');
// alert(article.dataset.article_id);

$(document).ready( () => {
  const collection = $("#comments");
  const article = document.getElementById('comments');
  const article_id = article.dataset.articleid; 
  // alert(article_id);
  if (collection.length > 0) {
    App.page = App.cable.subscriptions.create(
      {
        channel: "PageChannel", 
        article_id: article_id
        }, 
      {
        connected: function() {},
        disconnected: function() {},
        received: function(data) {
          // you need to insert this content into the page. 
          //this.collection() doesn't exist 
          return  $("#comments").append(data['message']);
                 
        },
        //it seems this show_comment does not run at all
        show_comment: function(message, article_id) {
          return this.perform('show_comment', {
            message: message,
            article_id: article_id
        });
      }
    });
    $(document).on('click', '[data-behavior~=page_show_comment]', function(event) {
      if ($.trim($('#text_area_content').val()).length > 1) {
        // debugger;
        App.page.show_comment(document.getElementById("text_area_content").value,article_id );
        collection.val($('#text_area_content').val());
        $('#text_area_content').val('');
        return event.preventDefault();
      }
    });
  }
});