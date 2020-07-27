import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zenithbankkyc/domain/entities/agent_login.dart';
import 'package:zenithbankkyc/domain/entities/agent_login_response.dart';
import 'package:zenithbankkyc/domain/usecases/staff_login_use_case.dart';
import 'package:mockito/mockito.dart';
import 'package:zenithbankkyc/domain/repositories/agent_login_repository.dart';

class MockAgentLoginRepository extends Mock implements AgentLoginRepository{}

void main(){
   StaffLoginUseCase useCase;
   MockAgentLoginRepository mockLoginRepository;

   setUp((){
     mockLoginRepository = MockAgentLoginRepository();
     useCase = StaffLoginUseCase(repository: mockLoginRepository);
   });

   final AgentLogin agentLogin = AgentLogin(Username: 'Nneoma.okoroafor',Password: 'Tinaoko@93',PINOTP: '');
   final AgentLoginResponse loginResponse = AgentLoginResponse(ResponseCode: '00', ResponseMessage: 'SUCCESSFUL');
   test('should get valid response payload when valid login details are provided', () async {
        // arrange
    when(mockLoginRepository.login(any)).
    thenAnswer((_)  async => Right(loginResponse));
        // act
    final result = await useCase(Params(login: agentLogin));
        // assert
    expect(result, Right(loginResponse));
    verify(mockLoginRepository.login(agentLogin));
    verifyNoMoreInteractions(mockLoginRepository);

  });
}

