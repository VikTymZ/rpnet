<template>
  <form id="post-editor" v-bind:action="target"  method="post" class="columns small-12">
    <input type="hidden" name="authenticity_token" v-bind:value="token">
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
      </div>
    </div>
  </form>
</template>

<script>
import Quill from 'quill';

export default({
  props: {
    post_json: null,
    target: null,
    token: null
  },

  mounted() {
    this.editor = new Quill("#content-editor",{
      modules: {
	toolbar: [
	  [{header: [1,2,3,4,5,false]}],
	  ['bold', 'italic', 'underline']
	]
      },
      theme: "snow",
      placeholder: "Write Something Incredible..."
    });

    if(this.post_json != null) {
      this.post = JSON.parse(this.post_json);
      this.title = this.post.title;
      this.permalink = this.post.slug;
      this.content = this.editor.root.innerHTML = this.post.content;
      this.tags = this.post.tags.map(tag => tag.name).join(',')
    }

    this.editor.on('text-change', function() {
      this.content = this.editor.root.innerHTML
    }.bind(this));
  },

  methods: {
    generatePermalink: function() {
      this.permalink = this.title.replace(/\s+/g, "-").toLowerCase();
    }
  },

  data() {
    return {
      editor: null,
      tags: null,
      permalink: null,
      title: null,
      content: null,
      post: null,
    }
  }
})
</script>
