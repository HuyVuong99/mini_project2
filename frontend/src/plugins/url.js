import axios from "axios";

const api = axios.create({
 baseURL: "http://103.170.123.206:1600",
});

export default api;