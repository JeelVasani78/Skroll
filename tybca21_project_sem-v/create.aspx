<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="create.aspx.vb" Inherits="tybca21_project_sem_v.create" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Skroll</title>
    <link rel="stylesheet" href="others.css" />
    <link rel="shortcut icon" type="x-icon" href="./images/nav_logo3.png">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    
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

                            <asp:Panel ID="s_p1" runat="server" CssClass="s_btn_holder">
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

                            <asp:Panel ID="s_p7" runat="server" CssClass="s_btn_holder s_selected">
                                <i class="fa-regular fa-square-plus"></i>
                                <asp:Label ID="s_l7" runat="server" Text="Create"></asp:Label>
                            </asp:Panel>

                            <asp:Panel ID="s_p8" runat="server" CssClass="s_btn_holder">
                                <asp:Image ID="sidebar_p_img" runat="server" cssClass="sidebar_p_img"/>
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
            <div class="art_holder">
                <div class="photo_art">
                    <div class="circle_art"></div>
                </div>
                <div class="video_art">
                    <div class="triangle_art"></div>
                </div>
            </div>
  
            <asp:FileUpload ID="s_post" runat="server" CssClass="s_post_btn" onchange="file_transfer()"/>
            <asp:Button ID="s_post_hidden" runat="server" style="display:none;" CssClass="s_post_hidden"/>
            <asp:Label ID="s_file_nm_hidden" runat="server" style="display:none;"></asp:Label>
            <asp:Label ID="s_file_extension_hidden" runat="server" style="display:none"></asp:Label>

            <asp:Panel ID="post_creater1" runat="server" CssClass="post_creater_closed">
                <div class="s_post_holder">
                    <asp:Literal ID="s_img" runat="server"></asp:Literal>
                </div>
                <div class="post_info1">
                    <div class="p_info_top">
                        <div class="p_u_info">
                            <div class="p_u_img_holder">
                                <asp:Image ID="p_u_img" runat="server" CssClass="image_holder" />
                            </div>
                            <asp:Label ID="p_unm" runat="server"></asp:Label>
                        </div>
                        <i class="fa-solid fa-xmark" id="close_post"></i>
                    </div>
                    <div class="p_info_middle">
                        <asp:TextBox ID="post_desc" runat="server" TextMode="MultiLine" CssClass="post_desc" placeholder="Write Something About Your Post" onkeyup="maxlimit(this, 2000)"></asp:TextBox>
                    </div>
                    <div class="p_info_bottom">
                        <asp:TextBox ID="post_loc" runat="server" CssClass="post_loc" placeholder="Enter Location" MaxLength="50"></asp:TextBox>
                        <asp:Button ID="p_submit_btn" runat="server" Text="Upload" CssClass="p_submit_btn"/>
                    </div>
                </div>
            </asp:Panel>
            
        </div>
        <!-- End Right -->   
            <!--<asp:Label ID="test_lbl" runat="server" ForeColor="red" CssClass="test_lbl" BackColor="white" Text="testinggg"></asp:Label>-->
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
                                    <asp:LinkButton ID="search_id" runat="server" CssClass="s_btn_holder" CommandArgument='<%# Eval("user_id") %>'>
                                        <asp:Image ID="search_profile" runat="server" cssClass="sidebar_p_img" ImageUrl='<%# Eval("user_p") %>'/>
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

                        <asp:Panel ID="noti_result" runat="server" Visible="true" CssClass="noti_result">
                            <asp:Repeater ID="noti_r1" runat="server">
                                <ItemTemplate>
                                    <asp:LinkButton ID="noti_info_holder" runat="server" CssClass="noti_info_holder">
                                        <asp:Image ID="noti_u_img" runat="server" CssClass="noti_u_img" ImageUrl='<%# Eval("user_p") %>'/>
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

        function maxlimit(txtval, max)
        {
            if(txtval.value.length>max)
            {
                txtval.value=txtval.value.substring(0, max);
                txtval.style.color="red";
                
            }
            else
            {
                txtval.style.color="white";
            }
        }

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

        /* Close Post */

        var close_post=document.querySelector("#close_post").addEventListener("click",function(){
            var post_creater=document.querySelector(".post_creater_opened");
            post_creater.className="post_creater_closed";

        });

        /* End Close Post */

        /* File Transfer */

        var file_btn=document.querySelector(".s_post_btn");
        var hidden_btn=document.querySelector(".s_post_hidden");

        function file_transfer()
        {
            var file=file_btn.files[0];
            if(file)
            {
                hidden_btn.click();
            }
        }

        /* End File Transfer */
    </script>

    <!-- End Script -->
</body>
</html>
