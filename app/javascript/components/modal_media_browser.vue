<template>
  <div id="media-explorer" class="row">
    <div class="columns small-12">
      <div class="callout row">
        <div v-if="media == null" id="media-explorer-empty" class="columns small-12">
				  <h3>Your Media Is Empty</h3>
        </div>
        <div class="columns small-12 medium-3 media-item" v-for="item in media">
				  <a v-on:click="selectMedia(item.url)"><img v-bind:src="item.url"></a>
        </div>
      </div>
    </div>
    <div class="columns small-12">
      <div class="button-group">
        <a v-on:click="uploadMedia()" class="button">Upload Media</a>
        <a v-on:click="closeModal()" class="button">Cancel</a>
      </div>
    </div>
  </div>
</template>

<script>
const axios = require('axios');
import Modal from 'components/modal_media_uploader.vue';

export default {
	props: {
	  token: null,
		xtoken: null,
  },

  mounted() {
	  this.getMediaList();
  },

  methods: {
		getMediaList: function() {
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
	      this.media = response.data;
      });
		},

	  selectMedia: function(mediaUrl) {
			console.log(this.token);
		  this.$vuedals.close(mediaUrl);
		},

	  uploadMedia: function() {
			var parentModal = this;
			this.$vuedals.open({
			  title: "Upload Image",
				component: Modal,
				props: {
				  token: this.token,
					xtoken: this.token,
				},
				onClose(shouldRefresh) {
				  if(shouldRefresh) {
				    parentModal.getMediaList();
					}
				},
			});
		},

		closeModal: function() {
		  this.$vuedals.close();
		}
  },
  
  data() {
    return {
		  media: null,
    }
  }
}
</script>
