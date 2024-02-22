# Use the official Python image as the base image
FROM python:3.9

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Create and set the working directory inside the container
WORKDIR /jobportal

# Install Python dependencies
COPY requirements.txt /jobportal/
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copy the Django project code into the container's working directory
COPY . /jobportal/

# Expose the port on which Django will run (change it if your app uses a different port)
EXPOSE 8000

# Run Django's development server (change it to your production WSGI server in production)
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
