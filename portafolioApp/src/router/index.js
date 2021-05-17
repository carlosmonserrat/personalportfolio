
import { createWebHistory, createRouter } from 'vue-router';
import Admin from "@/views/Admin";
import Home from "@/views/Home"
const routes = [
    {
        path: "/",
        name: "Home",
        component: Home,
    },
    {
        path: "/admin",
        name: "Admin",
        component: Admin,
    },
];

const router = createRouter({
    history: createWebHistory(),
    routes,
});

export default router;