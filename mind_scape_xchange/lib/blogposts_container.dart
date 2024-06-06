import 'package:flutter/material.dart';
import 'blogpost.dart';
import 'package:url_launcher/url_launcher.dart';

class BlogPostsContainer extends StatefulWidget {
  @override
  BlogPostsContainerState createState() => BlogPostsContainerState();
}

class BlogPostsContainerState extends State<BlogPostsContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _firstPostAnimation;
  late Animation<Offset> _secondPostAnimation;
  late Animation<Offset> _thirdPostAnimation;
  late List<BlogPost> blogPosts;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    // Initialize blog posts
    blogPosts = [
      BlogPost(
        title: 'First Blog Post',
        content: 'This is the content for the first blog post.',
        websiteUrl: 'https://example.com/first_blog_post',
      ),
      BlogPost(
        title: 'Second Blog Post',
        content: 'This is the content for the second blog post.',
        websiteUrl: 'https://example.com/second_blog_post',
      ),
      BlogPost(
        title: 'Third Blog Post',
        content: 'This is the content for the third blog post.',
        websiteUrl: 'https://mail.google.com/mail/u/1/#inbox',
      ),
    ];

    // Initialize animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            currentIndex = (currentIndex + 1) % blogPosts.length;
          });
          _controller.reset();
          Future.delayed(Duration(seconds: 5), () {
            _controller.forward();
          });
        }
      });

    // Define offset animations
    _firstPostAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _secondPostAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _thirdPostAnimation = Tween<Offset>(
      begin: const Offset(2.0, 0.0),
      end: const Offset(1.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Start the initial animation
    Future.delayed(Duration(seconds: 2), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

// Function to launch URL
  Future<void> _launchURL(url) async {
    if (await canLaunchUrl(url)) {
      // Use the URL string directly
      await launchUrl(url); // Use the URL string directly
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget buildBlogPost(
      BuildContext context, BlogPost blogPost, double width, double height) {
    return GestureDetector(
      onTap: () => _launchURL(blogPost.websiteUrl),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              blogPost.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 5),
            Text(
              blogPost.content,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double containerHeight = 150;
        double mainWidth = constraints.maxWidth * 0.8;
        double sneakPeekWidth = constraints.maxWidth * 0.2;

        return Stack(
          children: [
            SlideTransition(
              position: _firstPostAnimation,
              child: buildBlogPost(
                context,
                blogPosts[(currentIndex + 1) % blogPosts.length],
                mainWidth,
                containerHeight,
              ),
            ),
            SlideTransition(
              position: _secondPostAnimation,
              child: buildBlogPost(
                context,
                blogPosts[(currentIndex + 2) % blogPosts.length],
                sneakPeekWidth,
                containerHeight,
              ),
            ),
            SlideTransition(
              position: _thirdPostAnimation,
              child: buildBlogPost(
                context,
                blogPosts[(currentIndex + 3) % blogPosts.length],
                sneakPeekWidth,
                containerHeight,
              ),
            ),
          ],
        );
      },
    );
  }
}
