
<template>
  <div>
    <Post></Post>
    <CommentItem :comments="comments" @replay="replayComent"></CommentItem>
    <Comment @handelAddComment="addComment" :replay="replay" :type="type"></Comment>
  </div>
</template>

<script lang="ts">
import Post from './components/Post.vue'
import CommentItem from './components/CommentItem.vue';
import Comment from './components/Comment.vue';
export default {
  data() {
    return {
      comments: [
        {
          id: 1,
          autor: 'Joe Doe',
          text: 'test comment first',
          parend_id: null,
          image : 'https://picsum.photos/200/300', 
          children: [
            {
              id: 2,
              autor: 'Jane Doe',
              text: 'replay first',
              parend_id: 1,
              image : 'https://picsum.photos/200/300', 
            }
          ]
        },
        {
          id: 3,
          autor: 'Mari Doe',
          text: 'test comment second',
          parend_id: null,
          image : 'https://picsum.photos/200/300', 
          children: []
        }
      ],
      replay: null,
      type: ''
    }
  },
  components: {
    Post,
    CommentItem,
    Comment
  },
  methods: {
    addComment(message: string, author: string, replay: any, type: string) {
      let itemComments : Array<any>
      itemComments = [...this.comments]
      const newComment = {
        id: Date.now(),
        autor: author,
        text: message,
        parend_id: null,
        children: [] , 
        image : 'https://picsum.photos/200/300', 
      }
      if (replay) {
        if (type !== '' && type === 'comment') {
          const commentFind = itemComments.filter(item => item.id === replay.id)
          if (commentFind) {
            commentFind[0].children.push(
              {
                id: Date.now(),
                autor: author,
                text: message,
                parend_id: commentFind[0].id,
                image : 'https://picsum.photos/200/300', 
                children: []
              }
            ) // replay the comment
            itemComments = this.replaceObjectById(commentFind[0].id, itemComments, commentFind[0])
          }
        }
        if (type !== '' && type === 'sub_comment') {
          const subCommentFind = itemComments.filter(item => item.id === replay.parend_id)
          if (subCommentFind) {
            subCommentFind[0].children.push(
              {
                id: Date.now(), 
                autor: author,
                text: message,
                parend_id: replay.id,
                image : 'https://picsum.photos/200/300', 
                children: []
              }
            ) // replay the comment
            itemComments = this.replaceObjectById(subCommentFind[0].id, itemComments, subCommentFind[0])
          }
        }
      } else {
        itemComments.push(newComment)
      }
      localStorage.setItem('comments', JSON.stringify(itemComments))
      const storage = localStorage.getItem('comments')
      if(storage){
        this.comments = JSON.parse(storage)
      }
      this.type = ''
    },
    replaceObjectById(id: any, itemComments: Array<any>, newObject: any) : Array<any>  {
      const index = itemComments.findIndex(item => item.id === id);
      if (index !== -1) {
        itemComments[index] = { ...newObject };
        return itemComments;
      } else {
        return []
      }
    },
    replayComent(comment: any, type: string) {
      this.replay = comment
      this.type = type
    }

  },

  mounted() {
    if(localStorage.getItem('comments')){
      const storage = localStorage.getItem('comments')
      if(storage){
        this.comments = JSON.parse(storage)
      }
    }
  }

}
</script>

<style scoped>
.comment-list {
  list-style-type: none;
  padding: 0;
}

.comment {
  margin-bottom: 20px;
}

/* Ajoutez du style personnalisé ici si nécessaire */
.comment-list {
  list-style-type: none;
  padding: 0;
}

.comment {
  margin-bottom: 20px;
}

.comment .user-avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  margin-right: 10px;
}

.comment .comment-text {
  margin-bottom: 10px;
}

.gradient-custom { /* fallback for old browsers */ background: #4facfe; /* Chrome 10-25,
Safari 5.1-6 */ background: -webkit-linear-gradient(to bottom right, rgba(79, 172, 254,
1), rgba(0, 242, 254, 1)); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+,
Safari 7+ */ background: linear-gradient(to bottom right, rgba(79, 172, 254, 1), rgba(0,
242, 254, 1)) }
</style>
