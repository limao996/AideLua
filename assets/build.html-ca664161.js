import{_ as r,M as s,p as l,q as i,R as e,t as a,N as o,a1 as n}from"./framework-ea2a9e6e.js";const c={},d=e("h1",{id:"构建项目",tabindex:"-1"},[e("a",{class:"header-anchor",href:"#构建项目","aria-hidden":"true"},"#"),a(" 构建项目")],-1),p=e("p",null,"要二次打包，就先要构建项目",-1),h=e("p",null,"Aide Lua 的构建项目是通过调用 Termux 来实现的。因此，您需要手动配置环境。",-1),u=e("h2",{id:"下载-termux",tabindex:"-1"},[e("a",{class:"header-anchor",href:"#下载-termux","aria-hidden":"true"},"#"),a(" 下载 Termux")],-1),m=e("p",null,[a("Aide Lua 将终端应用写死为 "),e("code",null,"com.termux"),a(" ，因此您必须使用此包名的终端应用才可以直接从 Aide Lua 构建应用。")],-1),_=e("p",null,"Termux 有三个官方下载渠道",-1),g={href:"https://f-droid.org/zh_Hans/packages/com.termux/",target:"_blank",rel:"noopener noreferrer"},x={href:"https://github.com/termux/termux-app/releases",target:"_blank",rel:"noopener noreferrer"},b={href:"https://play.google.com/store/apps/details?id=com.termux",target:"_blank",rel:"noopener noreferrer"},f=e("div",{class:"custom-container warning"},[e("p",{class:"custom-container-title"},"警告"),e("p",null,[a("由于 Android 10 的问题，Termux 及其插件不再在 Google Play 商店上更新，已经被废弃。为 Android >= 7 发布的最后一个版本是 "),e("code",null,"v0.101"),a(" 。强烈建议不要再从 Play 商店安装 Termux 应用程序了。")])],-1),k=e("h2",{id:"安装-gradle-与-java",tabindex:"-1"},[e("a",{class:"header-anchor",href:"#安装-gradle-与-java","aria-hidden":"true"},"#"),a(" 安装 Gradle 与 Java")],-1),v={href:"https://www.coolapk.com/feed/19454309?shareKey=ODEwZWY2ZDg0YjQ3NjNjZjRlNTc~&shareUid=1432137&shareFrom=com.coolapk.market_13.0.1",target:"_blank",rel:"noopener noreferrer"},w=e("h2",{id:"允许第三方应用执行命令",tabindex:"-1"},[e("a",{class:"header-anchor",href:"#允许第三方应用执行命令","aria-hidden":"true"},"#"),a(" 允许第三方应用执行命令")],-1),T={href:"https://www.coolapk.com/apk/me.zhanghai.android.files",target:"_blank",rel:"noopener noreferrer"},y={href:"https://f-droid.org/packages/io.github.muntashirakon.AppManager/",target:"_blank",rel:"noopener noreferrer"},A=n(`<li>打开 AOSP 的“文件”应用程序<div class="language-bash" data-ext="sh"><pre class="language-bash"><code><span class="token comment"># 对于部分隐藏了“文件”应用程序的定制系统，您可以在 Termux 执行以下命令启动“文件”应用程序</span>
am start com.android.documentsui/.LauncherActivity
</code></pre></div></li><li>在“浏览其他应用中的文件”板块中选择“Termux”</li><li>进入 <code>.termux</code> 目录，使用“意图拦截器”打开 <code>termux.properties</code> 文件</li><li>将「MIME 类型」修改为 <code>text/plain</code></li><li>选择「发送编辑过的意图」，然后选择质感文件的「文本编辑器」</li><li>将 12 行的 <code># allow-external-apps = true</code> 取消注释并保存文件<div class="language-bash" data-ext="sh"><pre class="language-bash"><code><span class="token comment">### Allow external applications to execute arbitrary commands within Termux.</span>
<span class="token comment">### This potentially could be a security issue, so option is disabled by</span>
<span class="token comment">### default. Uncomment to enable.</span>
allow-external-apps <span class="token operator">=</span> <span class="token boolean">true</span>

<span class="token comment">### Default working directory that will be used when launching the app.</span>
<span class="token comment"># default-working-directory = /data/data/com.termux/files/home</span>
</code></pre><div class="highlight-lines"><br><br><br><div class="highlight-line"> </div><br><br><br></div></div></li>`,6),N=n('<div class="custom-container tip"><p class="custom-container-title">提示</p><p>如果您的文件管理器可以直接打开 <code>termux.properties</code> 文件，您就可以忽略 (5) 和 (6) 步，直接使用您的文件管理器打开此文件。</p></div><div class="custom-container warning"><p class="custom-container-title">警告</p><p>请不要使用「MT管理器」 <code>v2.13.0</code> 之前的版本打开此文件。因为某些原因可能无法保存。</p></div><h2 id="授予-aide-lua-权限" tabindex="-1"><a class="header-anchor" href="#授予-aide-lua-权限" aria-hidden="true">#</a> 授予 Aide Lua 权限</h2><p>首先，其次，最后</p>',4);function L(j,M){const t=s("ExternalLinkIcon");return l(),i("div",null,[d,p,h,u,m,_,e("ul",null,[e("li",null,[e("a",g,[a("F-Droid"),o(t)])]),e("li",null,[e("a",x,[a("GitHub Releases"),o(t)])]),e("li",null,[e("a",b,[a("Google Play 商店"),o(t)]),a("（已弃用）")])]),f,k,e("p",null,[e("a",v,[a("使用Termux构建Android Studio项目"),o(t)])]),w,e("ol",null,[e("li",null,[a("下载 "),e("a",T,[a("质感文件"),o(t)]),a(" 与 "),e("a",y,[a("App Manager"),o(t)])]),A]),N])}const D=r(c,[["render",L],["__file","build.html.vue"]]);export{D as default};
