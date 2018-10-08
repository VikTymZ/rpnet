<template>
<form class="row">
  <div class="columns small-12 button-group align-right">
    <a href="/dashboard/post/new" class="button">Create New Post</a>
    <a class="button"><i class="fas fa-trash-alt"></i></a>
  </div>

  <div class="columns small-12">
    <table>
      <thead>
	<td><input type="checkbox"></td>
	<td>Title</td>
	<td>Tags</td>
	<td>Status</td>
	<td>Published At</td>
	<td>Action</td>
      </thead>
      <tbody>
	<tr v-for="post in posts">
	  <td><input type="checkbox"></td>
	  <td>{{post.title}}</td>
	  <td>
            <div v-for="(tag,index) in post.tags">
              <small v-if="index != post.tags.length - 1">{{tag.name}},</small>
              <small v-else>{{tag.name}}</small>
            </div>
          </td>
	  <td>{{post.is_published ? "Published" : "Drafted"}}</td>
	  <td>{{post.created_at}}</td>
	  <td>
            <a v-bind:href="'/dashboard/post/edit/' + post.id"><i class="fas fa-edit"></i></a>
	    <a v-on:click="removePost(post.id)"><i class="fas fa-trash-alt"></i></a>
          </td>
	</tr>
      </tbody>
    </table>
  </div>

</form>
</template>

<script>
const axios = require('axios');

export default {
  props: ['token'],
  data() {
    return {
      posts: null,
      page: 1,
    }
  },
  methods: {
    getPosts: function() {
      axios.post(
        '/post',
        null,
        { headers: { 
            'Accept': 'application/json',
            'X-CSRF-TOKEN' : this.token
          } 
        }
      ).then(response => {
        this.posts = response.data.post;
      });
    },
    removePost: function(post_id) {
      axios.delete(
        '/post/remove',
        {
          params: {id: post_id},
          headers: {
            'X-CSRF-TOKEN' : this.token
          }
        }
      )
      window.location = '/dashboard'
    }
  },
  mounted() {
    this.getPosts();
  },
};
</script>
