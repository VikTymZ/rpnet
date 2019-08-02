<template>
  <div id="media-explorer" class="row">
    <div class="columns small-12">
			<div class="callout row">
        <div class="columns small-6">
		      <input type="file" ref="image" v-on:change="handleImage()">
				</div>
        <div class="columns small-6">
				  <img v-bind:src="image.url">
				</div>
        <div class="columns small-12">
          <div class="button-group">
            <a v-on:click="uploadMedia()" class="button">Upload</a>
            <a v-on:click="closeModal()" class="button">Done</a>
          </div>
				</div>
		  </div>
    </div>
  </div>
</template>

<script>
const axios = require('axios');

export default {
	props: {
	  token: null,
		xtoken: null,
	},

  mounted() {
	  this.image.url = '/assets/no-thumbnail-8f4f90a9979cc0ac80edc0f22811513ae3ccdd26b17a3b2c8bcc01818202a67b.jpg';
  },

  methods: {
	  selectMedia: function(mediaUrl) {
		  this.$vuedals.close(mediaUrl);
		},

		handleImage: function() {
		  this.image.file = this.$refs.image.files[0];
		},

	  uploadMedia: function() {
		  let formData = new FormData();
			formData.append('file', this.image.file);
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
				  this.image.url = response.data.media_url
					this.shouldRefresh = true;
				end
			}).catch(function(){
			  //TODO IMPLEMENT IF UPLOAD FAILED
			});
		},

		closeModal: function() {
		  this.$vuedals.close(this.shouldRefresh);
		},
  },
  
  data() {
    return {
		  image: { url: null, file: null },
			shouldRefresh: false,
    }
  }
}
</script>
