const Pusher = require('pusher');

const pusher = new Pusher({
      appId: 'PUSHER_APP_ID',
      key: 'PUSHER_KEY',
      secret: 'PUSHER_SECRET',
      cluster: 'PUSHER_CLUSTER',
      encrypted: true
});


module.exports = {
  broadcastArticle: function (event, context) {
    const article = event.data;
    const post = {
      "_id": article.id,
      "created": new Date(article.created),
      "title": article.title,
      "body": article.body
    };

    pusher.trigger('posts', 'new-post', post);
  }
}

