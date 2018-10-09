<template>
<div id="media-explorer" class="row">
  <div class="columns small-12">
    <div class="callout row">
      <div v-if="media == null" id="media-explorer-empty" class="columns small-12">
	<h3>Your Media Is Empty</h3>
      </div>
      <div class="columns small-12 medium-3 media-item" v-for="item in media">
	<img v-bind:src="item.url">
      </div>
    </div>
  </div>
  <div class="columns small-12">
    <div class="button-group">
      <a class="button">Upload Media</a>
    </div>
  </div>
</div>
</template>

<script>
const axios = require('axios');

export default {
  props: ['media'],

  mounted() {
    console.log(this.media);
  },

  methods: {
  },
  
  data() {
    return {
    }
  }
}
</script>
