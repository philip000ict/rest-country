<template>
  <div id="app">
    <div id="wrapper">
      <h1>REST Countries</h1>
      <label for="countries">Choose a Country:</label><br>

<select name="country" id="country">
  <option value="country-name" v-for="item of items" :key="item.id">
    {{ item.name.common }}
  </option>
</select> <br>


    <div v-for="item of items" :key="item.id" id="country-info">
      <button type="button" @click="displayinfo(item)"><h3>{{ item.name.official}} </h3></button>
      
      <img :src="item.flags.png" width=350 height = 200 class="flag" /><br>     
      2 character Country Code: <b>{{ item.cca2 }}</b><br>
      3 character Country Code: <b>{{ item.cca3 }}</b><br>      
      International Dialling IDD <b>{{ item.idd.root }}, {{ item.idd.suffixes }}</b><br>
      
      
      Native Country Name; {{ item.name.nativeName}}
      <button onclick="myFunction()">Click me</button>
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
      nativename:[]
    };
  },
  async created() {
    try {
      const res = await axios.get(`https://restcountries.com/v3.1/all`);
      this.items = res.data;
      this.nativename = this.name.nativeName
    } catch (error) {
      console.log(error);
    }
  },
  methods: {
    displayinfo(country) {
      alert(JSON.stringify(country, null, 4))
    },
  },
};
</script>
<style>
  #country-info{
    width: 350px;
    padding:20px;
    background-color: powderblue;
    margin: 20px;
    border-radius: 30px;
    border-color: blueviolet;
    border-width: 2px;
    display: inline-block;
} 
  #wrapper{
    background-color: salmon;

}

</style>
