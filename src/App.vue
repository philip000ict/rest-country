<template>
  <div id="app">
    <div id="wrapper">
      <h1>REST Countries</h1>
      <label for="countries">Choose a Country:</label><br>

<select name="country" id="country">
  <option value="country-name" v-for="item of items" :key="item.id">
    {{ item.name.common }}
  </option>
</select> 


    <div v-for="item of items" :key="item.id" id="country-info">
      <h3>{{ item.name.official}} </h3>
      
      <img :src="item.flags.png" class="w-full h-full" /><br>
      {{ item.flags.alt }}<br>
      {{ item.cca2 }}<br>
      {{ item.cca3 }}<br>
      
      {{ item.idd.root }}, {{ item.idd.suffixes }}<br>
    </div>
  </div>
</div>
</template>
<script>
import axios from "axios";
export default {
  name: "App",
  data() {
    return {
      items: [],
      itemName: "",
    };
  },
  async created() {
    try {
      const res = await axios.get(`https://restcountries.com/v3.1/all`);
      this.items = res.data;
    } catch (error) {
      console.log(error);
    }
  },
  methods: {
    async addItem() {
      const res = await axios.post(`https://restcountries.com/v3.1/all`, {
        name: this.itemName,
      });
      this.items = [...this.items, res.data];
      this.itemName = "";
    },
  },
};
</script>
<style>
  #country-info{
    width: 80%;
    padding:20px;
    background-color: powderblue;
    margin: auto;
    margin-top: 20px;
    border-radius: 30px;
    border-color: blueviolet;
    border-width: 2px;
    position: relative;

} 
  #wrapper{
    margin:auto;
    width:50%

}

</style>
