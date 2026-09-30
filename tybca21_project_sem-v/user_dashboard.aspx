<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="user_dashboard.aspx.vb" Inherits="tybca21_project_sem_v.user_dashboard" EnableSessionState="True"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Skroll</title>
    <link rel="stylesheet" href="user_dashboard.css" />
    <link rel="shortcut icon" type="x-icon" href="./images/nav_logo3.png">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.3.0/fonts/remixicon.css" rel="stylesheet"/>

</head>
<body>
    <div class="main">
    <form id="Form1" name="frm1" runat="server">
        <!-- Sidebar -->
        <div class="left">
            <div class="left_top">
                <div class="sidebar_logo_holder"></div>
            </div>
            <div class="left_middle">
                
                    <asp:ScriptManager ID="sm1" runat="server">
                    </asp:ScriptManager>

                    <asp:UpdatePanel ID="up1" runat="server">

                        <ContentTemplate>

                            <asp:Panel ID="s_p1" runat="server" CssClass="s_btn_holder s_selected">
                                <i class="fa-solid fa-house"></i>
                                <asp:Label ID="s_l1" runat="server" Text="Home"></asp:Label>
                            </asp:Panel>

                            <asp:Panel ID="s_p2" runat="server" CssClass="s_btn_holder search_btn" onclick="search_toggle()">
                                <i class="fa-solid fa-magnifying-glass" id="search_i"></i>
                                <asp:Label ID="s_l2" runat="server" Text="Search"></asp:Label>
                            </asp:Panel>

                            <asp:Panel ID="s_p3" runat="server" CssClass="s_btn_holder">
                                <i class="fa-regular fa-compass"></i>
                                <asp:Label ID="s_l3" runat="server" Text="Explore"></asp:Label>
                            </asp:Panel>

                            <asp:Panel ID="s_p4" runat="server" CssClass="s_btn_holder">
                                <i class="fa-solid fa-film"></i>
                                <asp:Label ID="s_l4" runat="server" Text="Reels"></asp:Label>
                            </asp:Panel>

                            <asp:Panel ID="s_p5" runat="server" CssClass="s_btn_holder">
                                <i class="fa-brands fa-facebook-messenger"></i>
                                <asp:Label ID="s_l5" runat="server" Text="Message"></asp:Label>
                            </asp:Panel>

                            <asp:Panel ID="s_p6" runat="server" CssClass="s_btn_holder noti_btn" onclick="noti_toggle()">
                                <i class="fa-regular fa-heart">
                                    <asp:Label ID="red_dot" runat="server" CssClass="red_dot_hidden"></asp:Label>
                                </i>
                                <asp:Label ID="s_l6" runat="server" Text="Notification"></asp:Label>
                            </asp:Panel>

                            <asp:Panel ID="s_p7" runat="server" CssClass="s_btn_holder">
                                <i class="fa-regular fa-square-plus"></i>
                                <asp:Label ID="s_l7" runat="server" Text="Create"></asp:Label>
                            </asp:Panel>

                            <asp:Panel ID="s_p8" runat="server" CssClass="s_btn_holder">
                                <div class="sidebar_p_img">
                                    <asp:Image ID="sidebar_p_img" runat="server" cssClass="image_holder"/>
                                </div>
                                <asp:Label ID="s_l8" runat="server" Text="Profile"></asp:Label>
                            </asp:Panel>

                    </ContentTemplate>

                </asp:UpdatePanel>

            </div>
            
            <div class="left_bottom">
                <div class="s_btn_holder more_btn" tabindex="-1">
                    <i class="fa-solid fa-bars"></i>
                    <p>More</p>
                    
                </div>
            </div>
            <div class="more_content" tabindex="-1">
                <div class="s_btn_holder" onclick="theme_toggle()">
                    <i class="fa-regular fa-moon"></i>
                    <p>Appearance</p>
                </div>
                <div class="s_btn_holder lo_div">
                    <i class="fa-solid fa-person-through-window"></i>
                    <p>Logout</p>
                    <asp:Button ID="logout_btn" runat="server" style="display:none;" />
                </div>
            </div>
            
        </div>
        <!-- End Sidebar -->

        <!-- Right -->
        <div class="right">
            <div class="right_part1">

                <div class="r_p1_top">
                <asp:Repeater ID="dash_top_r1" runat="server">
                <ItemTemplate>
                    <asp:LinkButton ID="dash_top_user_holder" runat="server" CssClass="dash_top_user_holder">
                        <div class="d_t_user_img_holder">
                            <asp:Image ID="d_t_user_img" runat="server" CssClass="image_holder" ImageUrl='<%# Eval("user_p") %>'/>
                        </div>
                        <asp:Label ID="d_t_usernm" runat="server" Text='<%# Eval("user_nm") %>'></asp:Label>
                        <asp:HiddenField ID="d_t_hidden_uid" runat="server" Value='<%# Eval("user_id") %>'/>
                    </asp:LinkButton>
                </ItemTemplate>
                </asp:Repeater>
                </div>

                <div class="r_p1_bottom">
                    <asp:Repeater ID="dash_post_r1" runat="server">
                    <ItemTemplate>
                    <asp:Panel ID="dash_post_holder" runat="server" CssClass="dash_post_holder">
                        <asp:Panel ID="d_p_top" runat="server" CssClass="d_p_top">
                            <div class="d_p_user_img_holder">
                                <asp:Image ID="d_p_user_img" runat="server" CssClass="image_holder" ImageUrl='<%# Eval("user_p") %>'/>
                            </div>
                            <div class="d_p_user_info">
                                <asp:LinkButton ID="d_p_usernm" runat="server" CssClass="d_p_usernm" Text='<%# Eval("user_nm") %>'></asp:LinkButton><br />
                                <asp:Label ID="d_p_location" runat="server" CssClass="d_p_location" Text='<%# Eval("p_location") %>'></asp:Label>
                                <asp:HiddenField ID="d_p_hidden_uid" runat="server" Value='<%# Eval("user_id") %>'/>
                                <asp:HiddenField ID="d_p_hidden_pid" runat="server" Value='<%# Eval("p_id") %>'/>
                            </div>
                        </asp:Panel>
                        <asp:Panel ID="d_p_middle" runat="server" CssClass="d_p_middle">
                            <asp:Image ID="d_post_img" runat="server" CssClass="image_holder" ImageUrl='<%# Eval("p_img") %>'/>
                        </asp:Panel>
                        <asp:Panel ID="d_p_bottom" runat="server" CssClass="d_p_bottom">
                            <div class="d_p_i_b1">
                        
                            <asp:LinkButton ID="like_icon1" runat="server" Cssclass="like_icon_outlined1">
                                <i class="fa-regular fa-heart" id="outlined_heart1"></i>
                                <i class="fa-solid fa-heart" id="filled_heart1"></i>
                                <asp:HiddenField ID="like_status" runat="server" />
                            </asp:LinkButton>

                            <asp:LinkButton ID="comment_icon1" runat="server" CssClass="comment_icon1">
                                <i class="ri-chat-3-line" id="cmt_icon1"></i>
                            </asp:LinkButton>
                        
                            </div>
                            <div class="d_p_i_b2">
                                <span class="see_likes_option">See Likes</span>
                            </div>
                            <div class="d_p_i_b3">
                                <asp:TextBox ID="cmt_txtbox1" runat="server" CssClass="cmt_txtbox" TextMode="MultiLine" placeholder="Add a comment" onkeyup="enable_cmt_btn()"></asp:TextBox>
                                <asp:Button ID="cmt_post_btn1" runat="server" CssClass="cmt_post_btn" Text="Post"  Enabled="true" /> 
                            </div>
                        </asp:Panel>
                    </asp:Panel>
                    </ItemTemplate>
                    </asp:Repeater>
                </div>

            </div>

            <div class="right_part2">
                <div class="r_p2_top">
                    <div class="dash_user_img_holder">
                        <asp:Image ID="dash_user_img" runat="server" CssClass="image_holder" />
                    </div>
                    <div class="dash_user_info">
                        <asp:HyperLink ID="dash_usernm" runat="server" NavigateUrl="~/u_profile.aspx" CssClass="dash_usernm"></asp:HyperLink><br />
                        <asp:Label ID="dash_full_usernm" runat="server"></asp:Label>
                    </div>
                </div>
                <div class="r_p2_bottom">
                    <span>Suggested for you</span>
                </div>
            </div>

        </div>
        <!-- End Right -->
            <!---->
        <!-- Search -->

        <div class="search_panel">

            <div class="search_top">
                <h2>Search</h2>
                <i class="fa-solid fa-xmark" id="search_cancel"></i>
            </div>

            <div class="search_bottom">
                <asp:Panel ID="search_p1" runat="server">

                    <asp:UpdatePanel ID="search_up1" runat="server">
                    
                        <ContentTemplate>
                            <asp:Panel ID="search_bar" runat="server" class="search_bar">
                                <i class="fa-solid fa-magnifying-glass"></i>
                                <asp:TextBox ID="search_input" runat="server" placeholder="Search" CssClass="search_input" AutoPostBack="true"></asp:TextBox>
                                
                            </asp:Panel>
                            <asp:Panel ID="search_result" runat="server" Visible="false" CssClass="search_result">
                                <asp:Repeater ID="search_r1" runat="server">
                                <ItemTemplate>
                                    <asp:LinkButton ID="search_id" runat="server" CssClass="s_btn_holder">
                                        <div class="sidebar_p_img">
                                            <asp:Image ID="search_profile" runat="server" cssClass="image_holder" ImageUrl='<%# Eval("user_p") %>'/>
                                        </div>
                                        <asp:Label ID="search_usernm" runat="server" Text='<%# Eval("user_nm") %>'></asp:Label>
                                        <asp:Label ID="s_f_user_id" runat="server" Text='<%# Eval("user_id") %>' style="display:none;"></asp:Label>
                                    </asp:LinkButton>
                                </ItemTemplate>
                                </asp:Repeater>
                            </asp:Panel>
                          
                        </ContentTemplate>
                       
                    </asp:UpdatePanel>
                </asp:Panel>
            </div>
        </div>

        <!-- End Search -->

        <!-- Notification -->

        <div class="noti_panel">
        
            <div class="noti_top">
                <h2>Notification</h2>
                <i class="fa-solid fa-xmark" id="noti_cancel"></i>
            </div>
            <div class="noti_bottom">
                <asp:UpdatePanel ID="noti_up1" runat="server">
                    <ContentTemplate>

                        <asp:Panel ID="noti_result" runat="server" CssClass="noti_result">
                            <asp:Repeater ID="noti_r1" runat="server">
                                <ItemTemplate>
                                    <asp:LinkButton ID="noti_info_holder" runat="server" CssClass="noti_info_holder">
                                        <div class="noti_u_img">
                                            <asp:Image ID="noti_u_img" runat="server" CssClass="image_holder" ImageUrl='<%# Eval("user_p") %>'/>
                                        </div>
                                        <div class="noti_u_info">
                                            <asp:Label ID="noti_unm" runat="server" CssClass="s_selected" Text='<%# Eval("user_nm") %>'></asp:Label>
                                            <asp:Label ID="noti_msg" runat="server" Text="started following you"></asp:Label>
                                        </div>
                                        <!--<asp:Button ID="noti_f_btn" runat="server" CssClass="noti_f_btn" Text="Follow"/>-->
                                        <asp:Label ID="noti_uid" runat="server" style="display:none" Text='<%# Eval("user_id") %>'></asp:Label>
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:Repeater>
                        </asp:Panel>

                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
                
        </div>

        <!-- End Notification -->

        <!-- User's Post -->
        
        <asp:Panel ID="post_panel" runat="server" CssClass="post_panel_closed">
            <div class="u_post_img_holder">
                <asp:Literal ID="post_literal" runat="server"></asp:Literal>
                <asp:Label ID="post_id" runat="server" style="display:none"></asp:Label>
            </div>
            <div class="u_post_info_holder">
                <div class="u_p_i_top">
                    <div class="u_p_info">
                        <div class="u_p_img_holder">
                            <asp:Image ID="u_p_img" runat="server" CssClass="image_holder" />
                        </div>
                        <asp:Label ID="u_p_nm" runat="server"></asp:Label>
                        
                    </div>
                    <i class="fa-solid fa-xmark" id="close_post"></i>
                </div>
                <div class="u_p_i_middle">
                    <asp:Panel ID="post_desc" runat="server" CssClass="post_desc" Visible="false">
                        <asp:LinkButton ID="cmt_user_info" runat="server" CssClass="cmt_user_info">
                            <div class="cmt_user_img_holder">
                                <asp:Image ID="cmt_user_img" runat="server" CssClass="image_holder" />
                            </div>
                            <asp:Label ID="cmt_user_nm" runat="server"></asp:Label>
                            <asp:Label ID="cmt_user_id" runat="server" style="display:none"></asp:Label>
                        </asp:LinkButton>
                        <asp:TextBox ID="user_cmt" runat="server" Rows="2" TextMode="MultiLine" CssClass="user_cmt" ReadOnly="true"></asp:TextBox>
                    </asp:Panel>

                    <asp:Repeater ID="cmt_r1" runat="server">
                    <ItemTemplate>
                    <asp:Panel ID="cmt_section" runat="server" CssClass="post_desc">
                        <asp:LinkButton ID="o_cmt_user_info" runat="server" CssClass="cmt_user_info">
                            <div class="cmt_user_img_holder">
                                <asp:Image ID="o_cmt_user_img" runat="server" CssClass="image_holder" ImageUrl='<%# Eval("user_p") %>'/>
                            </div>
                            <asp:Label ID="o_cmt_user_nm" runat="server" Text='<%# Eval("user_nm") %>'></asp:Label>
                            <asp:Label ID="o_cmt_user_id" runat="server" style="display:none" Text='<%# Eval("user_id") %>'></asp:Label>
                        </asp:LinkButton>
                        <asp:TextBox ID="o_user_cmt" runat="server" Text='<%# Eval("cmt") %>' Rows="2" TextMode="MultiLine" CssClass="user_cmt" ReadOnly="true"></asp:TextBox>
                    </asp:Panel>
                    </ItemTemplate>
                    </asp:Repeater>
                </div>
                <div class="u_p_i_bottom">
                    <div class="u_p_i_b1">
                        
                            <asp:LinkButton ID="like_icon" runat="server" Cssclass="like_icon_outlined">
                                <i class="fa-regular fa-heart" id="outlined_heart"></i>
                                <i class="fa-solid fa-heart" id="filled_heart"></i>
                                <asp:HiddenField ID="HiddenField1" runat="server" />
                            </asp:LinkButton>
                        
                    </div>
                    <div class="u_p_i_b2">
                        <span class="see_likes_option">See Likes</span>
                    </div>
                    <div class="u_p_i_b3">
                        <asp:TextBox ID="cmt_txtbox" runat="server" CssClass="cmt_txtbox" TextMode="MultiLine" placeholder="Add a comment" onkeyup="enable_cmt_btn()"></asp:TextBox>
                        <asp:Button ID="cmt_post_btn" runat="server" CssClass="cmt_post_btn" Text="Post"  Enabled="false" ForeColor="#484848"/> 
                    </div>
                </div>
            </div>

            
        </asp:Panel>
        
        <!-- End User's Post -->
        </form>
    </div>

    <!-- Script -->
    
    <script type="text/javascript">
        if (window.history.replaceState) 
        {
            window.history.replaceState(null, null, window.location.href);
        }
        function attachEventListeners()
        {
            var sidebar_logo=document.querySelector(".sidebar_logo_holder").addEventListener("click",function(){location.reload();});
            var h_btn=document.querySelector("#s_p1").addEventListener("click",function(){window.location.href="user_dashboard.aspx";});
            var ex_btn=document.querySelector("#s_p3").addEventListener("click",function(){window.location.href="explore.aspx";});
            var reels_btn=document.querySelector("#s_p4").addEventListener("click",function(){window.location.href="reels.aspx";});
            var msg_profile_btn=document.querySelector("#s_p5").addEventListener("click",function(){window.location.href="message.aspx";});
            var create_btn=document.querySelector("#s_p7").addEventListener("click",function(){window.location.href="create.aspx";});
            var u_profile_btn=document.querySelector("#s_p8").addEventListener("click",function(){window.location.href="u_profile.aspx";});
        }

        document.addEventListener("DOMContentLoaded", function () { 
            attachEventListeners();
        });

        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
            attachEventListeners();
        });
        /* User Redirection */
        /* End User Redirection */

        /*function s_p8()
        {
            window.location.href="u_profile.aspx";
        }*/

        /* More Toggle */
        var more_content=document.querySelector(".more_content");
        var more_btn=document.querySelector(".more_btn");

        more_btn.addEventListener("focus", function () {
            more_content.style.bottom = "0";
            more_content.style.zIndex = "5";
            more_content.style.opacity = "1";
            setTimeout(function () { more_content.focus(); }, 500);

        });
        more_content.addEventListener("blur", function () {
            more_content.style.bottom = "-20px";
            more_content.style.zIndex = "-1";
            more_content.style.opacity = "0";
        });
        /* End More Toggle */

        /* Searchbar Toggle */
        
        var search_btn=document.querySelector(".search_btn");
        var search_panel=document.querySelector(".search_panel");
        var search_cancel=document.querySelector("#search_cancel");

        function search_toggle(){
            if(search_panel.style.left=="250px")
            {
                search_panel.style.left="-60px";
            }
            else
            {
                search_panel.style.left="250px";
                noti_panel.style.left="-60px";
            }     
        }
        search_cancel.addEventListener("click",function(){
            if(search_panel.style.left=="250px")
            {
                search_panel.style.left="-60px";
            }
            else
            {
                search_panel.style.left="250px";
            }     
        });
        
        /* End Searchbar Toggle */

        /* Notification Toggle*/

        var noti_btn=document.querySelector(".noti_btn");
        var noti_panel=document.querySelector(".noti_panel");
        var noti_cancel=document.querySelector("#noti_cancel");
        var red_dot=document.querySelector("#red_dot");

        function noti_toggle(){
            if(noti_panel.style.left=="250px")
            {
                noti_panel.style.left="-60px";
            }
            else
            {
                noti_panel.style.left="250px";
                search_panel.style.left="-60px";
                red_dot.className="red_dot_hidden"
            }     
        }
        noti_cancel.addEventListener("click",function(){
            if(noti_panel.style.left=="250px")
            {
                noti_panel.style.left="-60px";
            }
            else
            {
                noti_panel.style.left="250px";
            }     
        });

        /* End Notificaton Toggle*/

        /* User redirection */

       /* function s_u_toggle() 
        {
            var s_u_btn=document.querySelector('#s_f_uid_btn');
            s_u_btn.click();
        }*/
 

        /* End User redirection */


        /* Theme */
        var main = document.querySelector(".main");
        var left = document.querySelector(".left");
        var right = document.querySelector(".right");

        //var main_bg = window.getComputedStyle(main).backgroundColor;
        //var main_bg=main.style.background;
        
        function theme_toggle() 
        {
            var main_bg = window.getComputedStyle(main).backgroundColor;

            //console.log("hello");
            //console.log(main_bg);

            if (main_bg === 'rgb(255, 255, 255)') 
            {
                main.style.backgroundColor = 'black';
                left.style.backgroundColor = 'black';
                right.style.backgroundColor = 'black';
                const allElements = document.querySelectorAll("*");
                allElements.forEach(element => {element.style.color = "#f1f1f1";});
            } 
            else 
            {
                main.style.backgroundColor = 'white';
                left.style.backgroundColor = 'white';
                right.style.backgroundColor = 'white';
                const allElements = document.querySelectorAll("*");
                allElements.forEach(element => {element.style.color = "black";});
            }
        }
        /* End Theme */

        /* logout */

        var lo_div=document.querySelector(".lo_div").addEventListener("click",function(){
            var logout_btn=document.querySelector("#logout_btn").click();
        });

        /* End logout */

        /* Close User Post */

        var close_u_post=document.querySelector("#close_post").addEventListener("click",function(){
            var post_panel=document.querySelector(".post_panel_opened");
                post_panel.className="post_panel_closed";
        });

        /* End Close User Post */

        /* Enable-Disable Comment Button */

        function enable_cmt_btn()
        {
            var cmt_textbox = document.getElementById('<%= cmt_txtbox.ClientID %>');
            var cmt_btn = document.getElementById('<%= cmt_post_btn.ClientID %>');

            if (cmt_textbox.value.trim() !== "") 
            {
                cmt_btn.disabled = false;
                cmt_btn.style.color="#0095f6";
            } 
            else 
            {
                cmt_btn.disabled = true;
                cmt_btn.style.color="#484848";
            }

            
        }

        /* End Enable-Disable Comment Button */

        /* Scroll The Top */

        document.querySelector('.r_p1_top').addEventListener('wheel', function (e) {
            e.preventDefault();
            this.scrollLeft += e.deltaY;
        });

        /* End Scroll The Top */
    </script>

    <!-- End Script -->
</body>
</html>
