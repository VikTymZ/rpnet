import Vue from 'vue/dist/vue';
import router from '../routers/dashboard.js';
import Dashboard from '../layouts/dashboard.vue';

import PostEditor from 'components/post_editor.vue';
import PostPanel from 'components/post_panel.vue';

import Vuedals from 'vuedals';
Vue.use(Vuedals);

Vue.component('post-editor', PostEditor);
Vue.component('post-panel', PostPanel);

const axios = require('axios');

document.addEventListener('DOMContentLoaded', () => {
  new Vue ({
    router,

    data: {
      postContent: ""
    },

    mounted() {
    },

    methods: {
      removePost: function(id) {
        axios.post('/post/remove', { id: id } ).then(function(response) {
          console.log(response);
          location.reload();
        })
      },

      publishPost: function() {
	var content_field = document.querySelector("input[name='post[content]']");
	    content_field.value = this.postContent;
      },
    }
  }).$mount('#dashboard')
})

