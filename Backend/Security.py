import jwt
import time



class Security:
    def __init__(self):
        self.secret_key = 'coffeshopXYZ'
        pass

    # Generate JWT key
    def generate_jwt_key(self,id: int, username: str, image : str, name : str):
        claims = {
            "id" : id,
            "username": username,
            "image" : image,
            "name" : name,
            "exp": int(time.time() * 1000) +  120 * 60 * 1000 # Token expires in 120 minutes
        }
        
        jwt_token = jwt.encode(claims, self.secret_key, algorithm='HS256')
        return jwt_token


    def validate_jwt_key(self, token):
        try:
            # Verify and decode the token
            decoded_token = jwt.decode(token, self.secret_key, algorithms=['HS256'])
            if time.time() * 1000 > decoded_token['exp']:
                return None
            return decoded_token
        except:
            return None
