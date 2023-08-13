
document.addEventListener("DOMContentLoaded", function() {
    const profilePhotoInput = document.querySelector('.photo-button');

    profilePhotoInput.addEventListener('change', (event) => {
        const allowedFormats = ['image/jpeg', 'image/jpg', 'image/png'];
        const selectedFile = event.target.files[0];

        if (selectedFile && !allowedFormats.includes(selectedFile.type)) {
            alert('Only JPEG and PNG formats are allowed for profile photo');
            event.target.value = ''; // Clear the input field
        }
    });
});
