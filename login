package FlightManagementSystem;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class LoginForm extends JFrame implements ActionListener {
    private Container container;
    private JLabel titleLabel;
    private JLabel usernameLabel;
    private JTextField usernameField;
    private JLabel passwordLabel;
    private JPasswordField passwordField;
    private JButton loginButton;
    private JButton registerButton;
    private JLabel resultLabel;

    public LoginForm() {
        setTitle("Login Form");
        setBounds(300, 90, 400, 300);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        setResizable(false);

        container = getContentPane();
        container.setLayout(null);

        titleLabel = new JLabel("Login Form");
        titleLabel.setFont(new Font("Arial", Font.PLAIN, 20));
        titleLabel.setSize(200, 30);
        titleLabel.setLocation(100, 30);
        container.add(titleLabel);

        usernameLabel = new JLabel("Username");
        usernameLabel.setFont(new Font("Arial", Font.PLAIN, 15));
        usernameLabel.setSize(100, 20);
        usernameLabel.setLocation(50, 100);
        container.add(usernameLabel);

        usernameField = new JTextField();
        usernameField.setFont(new Font("Arial", Font.PLAIN, 15));
        usernameField.setSize(150, 20);
        usernameField.setLocation(150, 100);
        container.add(usernameField);

        passwordLabel = new JLabel("Password");
        passwordLabel.setFont(new Font("Arial", Font.PLAIN, 15));
        passwordLabel.setSize(100, 20);
        passwordLabel.setLocation(50, 150);
        container.add(passwordLabel);

        passwordField = new JPasswordField();
        passwordField.setFont(new Font("Arial", Font.PLAIN, 15));
        passwordField.setSize(150, 20);
        passwordField.setLocation(150, 150);
        container.add(passwordField);

        loginButton = new JButton("Login");
        loginButton.setFont(new Font("Arial", Font.PLAIN, 15));
        loginButton.setSize(100, 20);
        loginButton.setLocation(150, 200);
        loginButton.addActionListener(this);
        container.add(loginButton);

        registerButton = new JButton("Go to Register");
        registerButton.setFont(new Font("Arial", Font.PLAIN, 15));
        registerButton.setSize(150, 20);
        registerButton.setLocation(150, 250);
        registerButton.addActionListener(e -> {
            dispose();
            new Register();
        });
        container.add(registerButton);

        resultLabel = new JLabel("");
        resultLabel.setFont(new Font("Arial", Font.PLAIN, 15));
        resultLabel.setSize(300, 25);
        resultLabel.setLocation(50, 300);
        container.add(resultLabel);

        setVisible(true);
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        String username = usernameField.getText();
        String password = new String(passwordField.getPassword());

        if (!username.isEmpty() && !password.isEmpty()) {
            if (username.equals("admin") && password.equals("admin")) {
                dispose();
                new AdminPage();
            } else {
                boolean loginSuccessful = false;

                try (BufferedReader reader = new BufferedReader(new FileReader("user_data.txt"))) {
                    String line;
                    while ((line = reader.readLine()) != null) {
                        String[] parts = line.split(",");
                        if (parts[0].equals(username) && parts[1].equals(password)) {
                            loginSuccessful = true;
                            break;
                        }
                    }

                    if (loginSuccessful) {
                        resultLabel.setText("Login Successful");
                        // Navigate to the user home page
                        dispose();
                        new HomePage();
                    } else {
                        resultLabel.setText("Invalid Username or Password");
                    }
                } catch (IOException ioException) {
                    resultLabel.setText("Error reading data");
                    ioException.printStackTrace();
                }
            }
        } else {
            resultLabel.setText("Please fill in all fields");
        }
    }

    public static void main(String[] args) {
        new LoginForm();
    }
}
