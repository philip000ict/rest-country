<template>
  <div id="app">
    <div id="wrapper">
      <h1>REST Countries</h1>
      <button type="button" @click="pagination(-25)">Back</button>
      <button type="button" @click="pagination(25)">Next</button>
<select name="country" id="country">
  <option value="country-name" v-for="item of name_list" :key="item.id">
    {{ item }}
  </option>
</select> <br>
    <div v-for="item of items" :key="item.id" id="country-info">
      <h2 type="button" @click="displayinfo(item)">
        {{ item.name.official}}</h2>
      
      <img :src="item.flags.png" width=350 height = 200 class="flag" /><br>     
      2 character Country Code: <b>{{ item.cca2 }}</b><br>
      3 character Country Code: <b>{{ item.cca3 }}</b><br>      
      International Dialling IDD <b>{{ item.idd.root }}, {{ item.idd.suffixes }}</b><br>
      Native Country Name; {{ item.name.nativeName}}
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
      all_countries:[],
      name_list:[],
      index_name_list:[],
      start:0,
    };
  },
  async created() {
    try {
      const res = await axios.get(`https://restcountries.com/v3.1/all?`);
      this.all_countries = res.data;
      for (let i = 0; i < this.all_countries.length; i++) {       
        this.name_list.push(this.all_countries[i].name.official)
        this.index_name_list.push(this.all_countries[i].name.official)
      }
      this.name_list.sort();
      this.pagination(0);
    } catch (error) {
      console.log(error);
    }
  },
  methods: {
    increment(page){
      this.start += page
    },
    pagination(page){
      //this.increment(page)
      this.items.length = 0;
      this.start += page;
      if(this.start < 0){this.start = 0}
      if(this.start > this.all_countries.length - 25){this.start = this.all_countries.length-25}
      for (let i = this.start+0; i < this.start+25; i++) {
        this.country_index = this.index_name_list.indexOf(this.name_list[i])
        console.log(this.name_list[i])
        console.log(this.index_name_list.indexOf(this.name_list[i]))
        this.items.push(this.all_countries[this.country_index]); 
      }
    },
    displayinfo(country) {      
      alert(JSON.stringify(country))
    },
  },
};
</script>
<style>
  #country-info{
    width: 350px;
    height: 500px;
    padding:20px;
    background-color: powderblue;
    margin-left: 20px;
    border-radius: 30px;
    border-color: blueviolet;
    border-width: 2px;
    display: inline-block;
} 
  #wrapper{
    padding: 20px;
}
  .body{

  }

  .button{
    border: none;
    background-color: lemonchiffon;
    margin:auto;
  }
</style>
