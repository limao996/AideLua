import{_ as c,M as i,p as l,q as u,N as a,U as s,a1 as p,R as n,t}from"./framework-ea2a9e6e.js";const d={},r=p('<h1 id="luaactivity" tabindex="-1"><a class="header-anchor" href="#luaactivity" aria-hidden="true">#</a> LuaActivity</h1><p>LuaActivity 继承自 <code>android.app.Activity</code>，因此您可以使用 Activity 的全部方法</p><p>AndroLua+ 的每一个 lua 页面都是 LuaActivity 以及他的子类。</p><p>变量 <code>activity</code> 与 <code>this</code> 都是当前页面都 LuaActivity 实例对象，因此您可以很方便的使用安卓各种api。</p><p>比如：</p>',5),m=n("div",{class:"language-lua line-numbers-mode","data-ext":"lua"},[n("pre",{class:"language-lua"},[n("code",null,[t("import "),n("span",{class:"token string"},'"android.view.View"'),t(`
import `),n("span",{class:"token string"},'"android.widget.LinearLayout"'),t(`

`),n("span",{class:"token comment"},"-- 创建一个TextView"),t(`
textView `),n("span",{class:"token operator"},"="),t(),n("span",{class:"token function"},"TextView"),n("span",{class:"token punctuation"},"("),t("activity"),n("span",{class:"token punctuation"},")"),t(`
textView`),n("span",{class:"token punctuation"},"."),n("span",{class:"token function"},"setText"),n("span",{class:"token punctuation"},"("),n("span",{class:"token string"},'"Hello World"'),n("span",{class:"token punctuation"},")"),t(`
`),n("span",{class:"token comment"},"-- 创建一个布局，并把view添加到布局内"),t(`
layout `),n("span",{class:"token operator"},"="),t(),n("span",{class:"token function"},"LinearLayout"),n("span",{class:"token punctuation"},"("),t("activity"),n("span",{class:"token punctuation"},")"),t(`
layout`),n("span",{class:"token punctuation"},"."),n("span",{class:"token function"},"addView"),n("span",{class:"token punctuation"},"("),t("textView"),n("span",{class:"token punctuation"},")"),t(`
`),n("span",{class:"token comment"},"-- 将layout加载到根view上"),t(`
activity`),n("span",{class:"token punctuation"},"."),n("span",{class:"token function"},"setContentView"),n("span",{class:"token punctuation"},"("),t("layout"),n("span",{class:"token punctuation"},")"),t(`
`)])]),n("div",{class:"line-numbers","aria-hidden":"true"},[n("div",{class:"line-number"}),n("div",{class:"line-number"}),n("div",{class:"line-number"}),n("div",{class:"line-number"}),n("div",{class:"line-number"}),n("div",{class:"line-number"}),n("div",{class:"line-number"}),n("div",{class:"line-number"}),n("div",{class:"line-number"}),n("div",{class:"line-number"}),n("div",{class:"line-number"})])],-1),k=n("div",{class:"language-lua line-numbers-mode","data-ext":"lua"},[n("pre",{class:"language-lua"},[n("code",null,[t("import "),n("span",{class:"token string"},'"android.view.View"'),t(`
import `),n("span",{class:"token string"},'"android.widget.LinearLayout"'),t(`

`),n("span",{class:"token comment"},"-- 创建一个TextView"),t(`
textView `),n("span",{class:"token operator"},"="),t(),n("span",{class:"token function"},"TextView"),n("span",{class:"token punctuation"},"("),t("this"),n("span",{class:"token punctuation"},")"),t(`
textView`),n("span",{class:"token punctuation"},"."),n("span",{class:"token function"},"setText"),n("span",{class:"token punctuation"},"("),n("span",{class:"token string"},'"Hello World"'),n("span",{class:"token punctuation"},")"),t(`
`),n("span",{class:"token comment"},"-- 创建一个布局，并把view添加到布局内"),t(`
layout `),n("span",{class:"token operator"},"="),t(),n("span",{class:"token function"},"LinearLayout"),n("span",{class:"token punctuation"},"("),t("this"),n("span",{class:"token punctuation"},")"),t(`
layout`),n("span",{class:"token punctuation"},"."),n("span",{class:"token function"},"addView"),n("span",{class:"token punctuation"},"("),t("textView"),n("span",{class:"token punctuation"},")"),t(`
`),n("span",{class:"token comment"},"-- 将layout加载到根view上"),t(`
this`),n("span",{class:"token punctuation"},"."),n("span",{class:"token function"},"setContentView"),n("span",{class:"token punctuation"},"("),t("layout"),n("span",{class:"token punctuation"},")"),t(`
`)])]),n("div",{class:"line-numbers","aria-hidden":"true"},[n("div",{class:"line-number"}),n("div",{class:"line-number"}),n("div",{class:"line-number"}),n("div",{class:"line-number"}),n("div",{class:"line-number"}),n("div",{class:"line-number"}),n("div",{class:"line-number"}),n("div",{class:"line-number"}),n("div",{class:"line-number"}),n("div",{class:"line-number"}),n("div",{class:"line-number"})])],-1),v=n("div",{class:"custom-container tip"},[n("p",{class:"custom-container-title"},"注意"),n("p",null,[t("在 Task 线程中，"),n("code",null,"this"),t(" 指的是 "),n("code",null,"LuaAsyncTask"),t(" 的实例对象。")])],-1),_=n("h2",{id:"getluadir",tabindex:"-1"},[n("a",{class:"header-anchor",href:"#getluadir","aria-hidden":"true"},"#"),t(" getLuaDir()")],-1),h=n("p",null,"获取Lua运行路径",-1);function b(y,w){const e=i("CodeGroupItem"),o=i("CodeGroup");return l(),u("div",null,[r,a(o,null,{default:s(()=>[a(e,{title:"activity"},{default:s(()=>[m]),_:1}),a(e,{title:"this"},{default:s(()=>[k]),_:1})]),_:1}),v,_,h])}const x=c(d,[["render",b],["__file","luaactivity.html.vue"]]);export{x as default};
