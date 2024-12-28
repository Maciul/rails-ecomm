# Little Jamon Shop

This project demonstrates a full-stack approach with a focus on efficient order management, secure payment integration, and a dynamic user interface.

![Screenshot 2024-12-28 at 6 20 23 PM](https://github.com/user-attachments/assets/6f748fdd-57dd-4b25-852b-ec791e19e935)

## Features

**Admin Panel:**

- **Order Management:** Efficiently manage orders with a turbo-frame powered interface to toggle between fulfilled and unfulfilled orders, streamlining order processing and providing a smooth user experience.
- **Product Management:** Add, edit, and organize product categories, details, and inventory with ease.
- **Stock Control:** Maintain accurate stock levels with integrated product stock management, ensuring real-time updates and preventing overselling.
- **Dashboard Metrics:** Gain insights into sales performance and key metrics through an informative admin dashboard, empowering data-driven decisions.
- **Chart.js Integration:** Visualize sales trends and other important data with interactive charts generated using Chart.js, enhancing data comprehension and analysis.

**E-commerce Site:**

- **Product Browsing:** User-friendly interface for browsing and discovering Jamon products with detailed descriptions and visuals.
- **Shopping Cart:** A seamless shopping experience with a dynamic cart managed through localStorage, allowing users to add and remove items with ease.
- **Stripe Integration:** Secure and reliable payment processing through Stripe, including order creation and confirmation via Stripe webhooks. This ensures a smooth and trustworthy checkout process for customers.

## Technologies Used

- **Ruby on Rails:** Backend framework for building the application logic and API.
- **Devise:** Flexible authentication solution for Rails, providing secure user registration and login functionality for admin users.
- **Turbo Frames:** Enhance user experience with dynamic page updates and seamless navigation within the admin panel.
- **Stripe API:** Secure payment processing and order management.
- **Stimulus.js:** JavaScript framework for adding interactivity to the frontend.
- **LocalStorage:** Efficiently manage the shopping cart data on the client-side.
- **Chart.js:** Create interactive and visually appealing charts for the admin dashboard.
- **Tailwind CSS:** Utility-first CSS framework for rapidly building a modern and responsive user interface.
- **PostgreSQL:** Relational database for storing product, order, and user data.
- **Heroku:** Cloud platform for deploying and hosting the application.

## Getting Started

1. **Clone the repository:** `git clone https://github.com/your-username/little-jamon-shop.git`
2. **Install dependencies:** `bundle install`
3. **Set up the database:** `rails db:create && rails db:migrate`
4. **Configure Stripe API keys:** Update the `config/credentials.yml.enc` file with your Stripe API keys.
5. **Start the server:** `rails server`

## Live Demo

[https://young-headland-28514-1c119e72e828.herokuapp.com/](https://young-headland-28514-1c119e72e828.herokuapp.com/)

## Future Enhancements

- **User Authentication:** Implement user accounts for order history and personalized experiences.
- **Advanced Search:** Allow users to filter products by various criteria.
- **Tables with Turbo Frames:** Table component with row inline editing.
- **Product Reviews:** Enable customers to leave reviews and ratings for products.
- **Email Notifications:** Send order confirmation and shipping updates via email.
