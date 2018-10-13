<template>
  <form id="post-editor" v-bind:action="target"  method="post" class="columns small-12">
    <input type="hidden" name="authenticity_token" v-bind:value="token">
    <input type="hidden" name="post[thumb_url]" v-bind:value="thumbnail.url">
    <div class="row">
      <div class="columns small-12 medium-8">
	<input type="text" v-model="title" v-on:blur="generatePermalink()" name="post[title]" placeholder="Post Title">
        <input type="hidden" v-bind:value="content" name="post[content]">
	<div id="content-editor"></div>
      </div>
      <div class="columns small-12 medium-4">
        <div id="post-meta-info" class="callout editor-widget">
	  <div class="row">
	    <div class="columns small-12 medium-12">
              <div class="editor-widget-header">
                <h4 class="editor-widget-title">Publish</h4>
              </div>
              <div class="editor-widget-body">
		<ul>
		  <li>
                    <p>Status:</p>
                    <select name=post[is_published]>
                      <option value="true">Published</option>
                      <option value="false">Drafted</option>
                    </select>
                  </li>
		  <li><p>Permalink:</p><input type="text" name="post[slug]" v-bind:value="permalink" placeholder="Post URL" disabled="true"></li>
		</ul>
              </div>
	    </div>
	    <div class="editor-widget-footer columns small-12 medium-12">
              <div class="expanded button-group">
		<input type="submit" value="Publish Post" class="button">
	      </div>
	    </div>
	  </div>
        </div>

        <div class="callout editor-widget">
	  <div class="editor-widget-header">
	    <h4 class="editor-widget-title">Tags</h4>
	  </div>
	  <div class="editor-widget-body">
	    <input v-model="tags" type="text" name="post[tags_str]" placeholder="Post Tags (use coma to seperate)">
	  </div>
        </div>

        <div id="thumbnail-widget" class="callout editor-widget">
	  <div class="editor-widget-header">
	    <h4 class="editor-widget-title">Thumbnail</h4>
	  </div>
	  <div class="editor-widget-body">
            <img v-bind:src="thumbnail.url">
            <div class="callout">
	      <input type="file" ref="thumbnail" v-on:change="handleThumb()">
              <a v-on:click="uploadMedia()" class="expanded button">Upload Thumbnail</a>
              <a v-on:click="openMedia()" class="expanded button">Choose From Media</a>
              <vuedal></vuedal>
            </div>
	  </div>
        </div>
      </div>
    </div>
  </form>
</template>

<script>
import Quill from 'quill';
import {Component as Vuedal, Bus as VuedalsBus} from 'vuedals';
import Modal from 'components/modal_media.vue';
const axios = require('axios');

export default({
  props: {
    post_json: null,
    target: null,
    token: null,
    xtoken: null
  },

  components: {
    Vuedal
  },

  mounted() {
    this.editor = new Quill("#content-editor",{
      modules: {
	toolbar: [
          ['bold', 'italic', 'underline', 'strike'],
          ['blockquote', 'code-block'],

          ['link','image'],

          [{ 'header': 1 }, { 'header': 2 }],
          [{ 'list': 'ordered'}, { 'list': 'bullet' }],
          [{ 'script': 'sub'}, { 'script': 'super' }],
          [{ 'indent': '-1'}, { 'indent': '+1' }],
          [{ 'direction': 'rtl' }],

          [{ 'size': ['small', false, 'large', 'huge'] }],
          [{ 'header': [1, 2, 3, 4, 5, 6, false] }],

          [{ 'color': [] }, { 'background': [] }],
          [{ 'font': [] }],
          [{ 'align': [] }],

          ['clean']
	]
      },
      theme: "snow",
      placeholder: "Write Something Incredible..."
    });

    // Set Default Thumbnail
    this.thumbnail.url = '/assets/no-thumbnail-8f4f90a9979cc0ac80edc0f22811513ae3ccdd26b17a3b2c8bcc01818202a67b.jpg';

    if(this.post_json != null) {
      this.post = JSON.parse(this.post_json);
      this.title = this.post.title;
      this.permalink = this.post.slug;
      this.content = this.editor.root.innerHTML = this.post.content;
      this.tags = this.post.tags.map(tag => tag.name).join(',')
      this.thumbnail.url = this.post.thumb_url
    }

    this.editor.on('text-change', function() {
      this.content = this.editor.root.innerHTML
    }.bind(this));
  },

  methods: {
    generatePermalink: function() {
      this.permalink = this.title.replace(/\s+/g, "-").toLowerCase();
    },

    handleThumb: function() {
      this.thumbnail.file = this.$refs.thumbnail.files[0];
      console.log(this.thumbnail.file);
    },

    uploadMedia: function() {
      let formData = new FormData();
      formData.append('file', this.thumbnail.file);
      formData.append('authenticity_token', this.token);

      axios.post(
        '/media/upload',
        formData,
        {
          headers: {
            'Content-Type': 'multipart/form-data',
          }
        }
      ).then(response => {
        if(response.data.is_success)
          this.thumbnail.url = response.data.media_url
        end
      }).catch(function(){

      });
    },

    openMedia: function() {
      axios.post(
        '/media',
        null,
        {
          headers: {
            'X-CSRF-TOKEN' : this.xtoken
          },
          params: {
            page: 1
          }
        }
      ).then(response => {
	this.$vuedals.open({
	  title: "Media Explorer",
	  component: Modal,
	  props: {
	    media: response.data
	  }
	});
      });
    },

  },

  data() {
    return {
      editor: null,
      tags: null,
      permalink: null,
      title: null,
      content: null,
      post: null,
      thumbnail: { url: null, file: null }
    }
  }
})
</script>
