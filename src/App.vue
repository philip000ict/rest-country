<template>
  <div id="app">
    <div id="wrapper">
      <div id="navbar">
      <h1>REST Countries</h1>
      <button class ="navbutton" type="button" @click="pagination(-25)">Back</button>
      <button class ="navbutton" type="button" @click="pagination(25)">Next</button>

  <select name="country" id="country" >
    <option value="country-name" v-for="item of name_list" :key="item.id" >
      {{ item }}
    </option>
  </select> <br>
  </div>
  <div id="flagdiv">
    <div class="card" v-for="item of items" :key="item.id"  @click="displayinfo(item)">
      <p class="countryName">
        {{ item.name.official}}</p>
      
        <img :src="item.flags.png" width=350 height = 200 class="flag" /><br>     
        2 character Country Code: <b>{{ item.cca2 }}</b><br>
        3 character Country Code: <b>{{ item.cca3 }}</b><br>      
        International Dialling IDD <b>{{ item.idd.root }}, {{ item.idd.suffixes }}</b>
      </div>
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
    single_country(name){
      console.log(name)
    },
    pagination(page){
      //this.increment(page)
      this.items.length = 0;
      this.start += page;
      if(this.start < 0){this.start = 0}
      if(this.start > this.all_countries.length - 25){this.start = this.all_countries.length-25}
      for (let i = this.start+0; i < this.start+25; i++) {
        this.country_index = this.index_name_list.indexOf(this.name_list[i])
        this.items.push(this.all_countries[this.country_index]); 
      }
    },
    displayinfo(country) {     
      var country_string = JSON.stringify(country)
      country_string = this.beautify(country_string)     
      alert(country_string)
    }, 
    beautify(obj){
      obj = obj.replace(/[{}]/g," ")
      obj = obj.replace(/[":"]/g,' ')
      obj = obj.replace(/[,]/g,'\n')
      return obj
    }
  },
};
</script>
<style>
  .card{
    width: 350px;
    height: 350px;
    padding:20px;
    background-color: powderblue;
    margin: 20px;
    border-radius: 30px;
    display:inline-block;
    vertical-align: top;

} 
.countryName{
  font-size: 24px;
  text-align: center;
}
  #wrapper{
    margin-top: 20px;
    padding: 20px;
}
  .navbutton{
    height:50px;
    width: 100px;
    margin: 20px;
    background-color: powderblue;
  }
#navbar{
  background-color: aliceblue;
  position: fixed; /* Set the navbar to fixed position */
  top: 0; /* Position the navbar at the top of the page */
  width: 100%; /* Full width */
  margin-bottom:20px;
}
  .button{
    border: none;
    background-color: lemonchiffon;
    
  }
  #flagdiv{
    padding-top: 200px;
  }
</style>
